﻿/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package doot.model.encoder {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
         * Class that converts BitmapData into a valid PNG
         */     
        public final class PNGEncoder{
			/**
			 * Created a PNG image from the specified BitmapData
			 *
			 * @param image The BitmapData that will be converted into the PNG format.
			 * @return a ByteArray representing the PNG encoded image data.
			 * @langversion ActionScript 3.0
			 * @playerversion Flash 9.0
			 * @tiptext
			 */

			/* add meta data to png http://wonderfl.net/c/oVSK*/

	        public static const CHAR_SET:String = "iso-8859-1";
	        public static const IDAT_ID:uint = 0x49444154;
	        public static const tEXt_ID:uint = 0x74455874;

            private static var crcTable:Array;
            private static var crcTableComputed:Boolean = false;

            public static function encode(img:BitmapData, meta:Object = null):ByteArray {
	            // Create output byte array
	            var png:ByteArray = new ByteArray();
	            // Write PNG signature
	            png.writeUnsignedInt(0x89504e47);
	            png.writeUnsignedInt(0x0D0A1A0A);
	            // Build IHDR chunk
	            var IHDR:ByteArray = new ByteArray();
	            IHDR.writeInt(img.width);
	            IHDR.writeInt(img.height);
	            IHDR.writeUnsignedInt(0x08060000); // 32bit RGBA
	            IHDR.writeByte(0);
	            writeChunk(png,0x49484452,IHDR);
	            
	            // meta data insertion
	            for (var k:String in meta) {
	               writeChunk_tEXt(png, k, meta[k]);
	            }
	            
	            // Build IDAT chunk
	            var IDAT:ByteArray= new ByteArray();
	            for(var i:int=0;i < img.height;i++) {
	                // no filter
	                IDAT.writeByte(0);
	                var p:uint;
	                var j:int;
	                if ( !img.transparent ) {
	                    for(j=0;j < img.width;j++) {
	                        p = img.getPixel(j,i);
	                        IDAT.writeUnsignedInt(
	                            uint(((p&0xFFFFFF) << 8)|0xFF));
	                    }
	                } else {
	                    for(j=0;j < img.width;j++) {
	                        p = img.getPixel32(j,i);
	                        IDAT.writeUnsignedInt(
	                            uint(((p&0xFFFFFF) << 8)|
	                            (p>>>24)));
	                    }
	                }
	            }
	            IDAT.compress();
	            writeChunk(png,0x49444154,IDAT);
	            // Build IEND chunk
	            writeChunk(png,0x49454E44,null);
	            // return PNG
	            
	            return png;
            }
        
            private static function writeChunk(png:ByteArray, 
                    type:uint, data:ByteArray):void {
                if (!crcTableComputed) {
                    crcTableComputed = true;
                    crcTable = [];
                    var c:uint;
                    for (var n:uint = 0; n < 256; n++) {
                        c = n;
                        for (var k:uint = 0; k < 8; k++) {
                            if (c & 1) {
                                c = uint(uint(0xedb88320) ^ 
                                    uint(c >>> 1));
                            } else {
                                c = uint(c >>> 1);
                            }
                        }
                        crcTable[n] = c;
                    }
                }
                var len:uint = 0;
                if (data != null) {
                    len = data.length;
                }
                png.writeUnsignedInt(len);
                var p:uint = png.position;
                png.writeUnsignedInt(type);
                if ( data != null ) {
                    png.writeBytes(data);
                }
                var e:uint = png.position;
                png.position = p;
                c = 0xffffffff;
                for (var i:int = 0; i < (e-p); i++) {
                    c = uint(crcTable[
                        (c ^ png.readUnsignedByte()) & 
                        uint(0xff)] ^ uint(c >>> 8));
                }
                c = uint(c^uint(0xffffffff));
                png.position = e;
                png.writeUnsignedInt(c);
            }

	        private static function writeChunk_tEXt(png:ByteArray, key:String, value:String):void{
	            if (key == null || key.length == 0 || key.length > 79) {
	                return;
	            }
	            if (value == null) {
	                value = "";
	            }
	            // the spec says this should be latin1,
	            // but UTF8 is probably ok, but be care of overflows
	            var tEXt:ByteArray = new ByteArray();
	            tEXt.writeMultiByte(key, CHAR_SET);
	            tEXt.writeByte(0x0);
	            tEXt.writeMultiByte(value, CHAR_SET);
	            writeChunk(png, tEXt_ID, tEXt);
	        }

	        public static function getMetaData(png:ByteArray):Object{
	            var metaData:Object = {};
	            var i:int, j:int, key:String, value:String;
	            for(i = 0; i < png.length - 4; i++){
	                png.position = i;
	                // look for the tEXt chunk type
	                if(png.readUnsignedInt() == tEXt_ID){
	                    // chunks are broken into length, type, data and CRC
	                    // we've stopped at the type, wind back to get the length
	                    png.position = i - 4;
	                    var totalLength:int = png.readUnsignedInt();
	                    // the key/value is broken with a single 0x0 byte
	                    var keyLength:int = 0;
	                    for(j = 0; j < totalLength; j++){
	                        png.position = i + 4 + j;
	                        if(png.readByte() == 0x0){
	                            keyLength = j;
	                            break;
	                        }
	                    }
	                    // capture the key
	                    png.position = i + 4;
	                    key = png.readMultiByte(keyLength, CHAR_SET);
	                    // capture the value
	                    png.position = i + 4 + keyLength + 1;
	                    value = png.readMultiByte(totalLength - (keyLength + 1), CHAR_SET);
	                    metaData[key] = value;
	                }
	                // quit searching once the IDAT chunk is encountered
	                // pngs encoded by this class store the metadata before the IDAT
	                if(png.readUnsignedInt() == IDAT_ID){
	                    break;
	                }
	            }
           		return metaData;
       	 	}
	}
}
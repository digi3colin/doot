﻿package doot.net {
	import doot.collection.Queue;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.net.ILoader;

	import flash.events.Event;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;


	/**
	 * @author colin
	 */
	public class LoadingQueue extends FASTEventDispatcher implements ILoader {
		private var loader:ILoader;
		private var queueId:int = 0;
		public function LoadingQueue(loader:ILoader,queueId:int=0){
			this.loader = loader;
			this.queueId = queueId;
			this.loader.when(LoaderEvent.READY, 		nextCommand);
			this.loader.when(LoaderEvent.IO_ERROR, 		nextCommand);
			this.loader.when(LoaderEvent.UNLOAD, 		nextCommand);

			this.loader.when(LoaderEvent.COMPLETE, 		forwardEvent);
			this.loader.when(LoaderEvent.IO_ERROR, 		forwardEvent);
			this.loader.when(LoaderEvent.HTTP_STATUS, 	forwardEvent);
			this.loader.when(LoaderEvent.OPEN, 			forwardEvent);
			this.loader.when(LoaderEvent.PROGRESS, 		forwardEvent);
			this.loader.when(LoaderEvent.UNLOAD, 		forwardEvent);
			this.loader.when(LoaderEvent.READY,			forwardEvent);
		}

		private function nextCommand(e:Event):void{
			Queue.instance(queueId).next();
		}

		private function forwardEvent(e:Event):void{
			dispatchEvent(e);
		}

		public function load(url : String) : Boolean {
			Queue.instance(queueId).addCommand(new CommandLoad(loader, url ,this));
			return false;
		}

		public function sendAndLoad(url : String, postData : URLVariables, method : String) : Boolean {
			Queue.instance(queueId).addCommand(new CommandSendAndLoad(loader, url, postData, method,this));
			return false;
		}

		public function sendBinaryAndLoad(url : String, binary : ByteArray) : Boolean {
			Queue.instance(queueId).addCommand(new CommandSendBinaryAndLoad(loader, url, binary,this));
			return false;
		}

		public function unload() : void {
			loader.unload();
		}

		public function getBytesLoaded() : Number {
			return loader.getBytesLoaded();
		}

		public function getBytesTotal() : Number {
			return loader.getBytesTotal();
		}

		public function getContext() : * {
			return loader.getContext();
		}
	}
}
import doot.net.LoadingQueue;
import doot.utils.ICommand;

import com.fastframework.net.ILoader;

import flash.net.URLVariables;
import flash.utils.ByteArray;


class CommandLoad implements ICommand {
	private var loader:ILoader;
	private var url:String;
	private var retain:LoadingQueue;

	public function CommandLoad(loader:ILoader,url : String,retain:LoadingQueue){
		this.loader = loader;
		this.url = url;
		this.retain = retain;
	}
	public function execute() : void {
		loader.load(this.url);
	}	
}

class CommandSendAndLoad implements ICommand {
	private var loader:ILoader;
	private var url:String;
	private var postData:URLVariables;
	private var method:String;
	private var retain:LoadingQueue;

	public function CommandSendAndLoad(loader:ILoader,url : String, postData : URLVariables, method : String, retain:LoadingQueue){
		this.loader = loader;
		this.url = url;
		this.postData = postData;
		this.method = method;
		this.retain = retain;
	}
	public function execute() : void {
		loader.sendAndLoad(this.url, this.postData, this.method);
	}
}

class CommandSendBinaryAndLoad implements ICommand{
	private var loader:ILoader;
	private var url:String;
	private var binary:ByteArray;
	private var retain:LoadingQueue;

	public function CommandSendBinaryAndLoad(loader:ILoader, url : String, binary : ByteArray,retain:LoadingQueue){
		this.loader = loader;
		this.url = url;
		this.binary = binary;
		this.retain = retain;
	}

	public function execute() : void {
		this.loader.sendBinaryAndLoad(this.url, this.binary);
	}
}
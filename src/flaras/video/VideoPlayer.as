/**
 * FLARAS - Flash Augmented Reality Authoring System
 * --------------------------------------------------------------------------------
 * Copyright (C) 2011-2012 Raryel, Hipolito, Claudio
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * --------------------------------------------------------------------------------
 * Developers:
 * Raryel Costa Souza - raryel.costa[at]gmail.com
 * Hipolito Douglas Franca Moreira - hipolitodouglas[at]gmail.com
 * 
 * Advisor: Claudio Kirner - ckirner[at]gmail.com
 * http://www.ckirner.com/flaras
 * Developed at UNIFEI - Federal University of Itajuba (www.unifei.edu.br) - Minas Gerais - Brazil
 * Research scholarship by FAPEMIG - Fundação de Amparo à Pesquisa no Estado de Minas Gerais
 */

package flaras.video 
{
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	public class VideoPlayer 
	{
		private var netStream:NetStream;
		private var video:Video;
		private var repeatVideo:Boolean;
		private var videoPath:String;
		
		public function VideoPlayer(pVideoPath:String, width:uint, height:uint, pRepeatVideo:Boolean) 
		{
			var netConnection:NetConnection;
			var urlLoader:URLLoader;
			
			urlLoader = new URLLoader(new URLRequest(pVideoPath));
			urlLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			
			videoPath = pVideoPath;
			repeatVideo = pRepeatVideo;
			netConnection = new NetConnection();
			netConnection.connect(null);
			
			netStream = new NetStream(netConnection);
			netStream.addEventListener(NetStatusEvent.NET_STATUS, videoProgressHandler);
			netStream.client = { };
			netStream.play(videoPath);
			
			video = new Video(width, height);
			video.smoothing = true;
			video.attachNetStream(netStream);
		}
		
		public function closeStream():void
		{
			if (netStream != null)
			{
				netStream.removeEventListener(NetStatusEvent.NET_STATUS, videoProgressHandler);
				netStream.close();
			}
		}	
		
		public function getNetStream():NetStream
		{
			return netStream;
		}
		
		public function getVideo():Video
		{
			return video;
		}
		
		private function videoProgressHandler(event:NetStatusEvent):void 
		{
			if (event.info.code == "NetStream.Play.Stop" )
			{
				if (repeatVideo)
				{
					netStream.play(videoPath);	
				}
				else
				{
					closeStream();
					VideoManager.finishedPlayingVideo(this);
				}				
			}
		}			
	}
}
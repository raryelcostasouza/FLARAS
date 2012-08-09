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

package flaras.model.scene 
{
	import flaras.controller.constants.*;
	import flaras.model.point.*;
	import org.papervision3d.core.math.*;
	
	public class VideoScene extends FlarasScene
	{
		private var _videoFilePath:String;
		private var _repeatVideo:Boolean;
		private var _width:Number;
		private var _height:Number;
		
		public function VideoScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D, videoFilePath:String, repeatVideo:Boolean, width:Number, height:Number) 
		{
			super(this, parentPoint, translation, rotation, scale);
			_videoFilePath = videoFilePath;
			_repeatVideo = repeatVideo;
			_width = width;
			_height = height;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_videoFilePath = null;
		}
		
		public function getVideoFilePath():String { return _videoFilePath; }
		public function getRepeatVideo():Boolean { return _repeatVideo; }
		public function getWidth():Number { return _width; }
		public function getHeight():Number { return _height; }
		
		public function setVideoPath(videoFilePath:String):void 
		{
			_videoFilePath = videoFilePath;
		}
		
		public function setRepeatVideo(repeatVideo:Boolean):void
		{
			_repeatVideo = repeatVideo;
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
		}
		
		override public function getListOfFilesAndDirs():Vector.<String> 
		{
			var listOfFilesAndDirs:Vector.<String>;
			
			listOfFilesAndDirs = super.getListOfFilesAndDirs();
			listOfFilesAndDirs.push(FolderConstants.getFlarasAppCurrentFolder() + "/" + _videoFilePath);
			
			return listOfFilesAndDirs;
		}	
		
		override public function getBaseSceneFilePath():String 
		{
			return FolderConstants.getFlarasAppCurrentFolder() + "/" + _videoFilePath;
		}
	}
}
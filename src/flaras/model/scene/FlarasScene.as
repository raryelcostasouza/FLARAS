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
	import flash.errors.*;
	import org.papervision3d.core.math.*;
	
	public class FlarasScene 
	{
		private var _animation:AnimationScene;
		private var _audio:AudioScene;
		private var _parentPoint:Point;
		
		private var _label:String;
		private var _translation:Number3D;
		private var _rotation:Number3D;
		private var _scale:Number3D;
		
		public function FlarasScene(selfReference:FlarasScene, parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D, pLabel:String) 
		{
			//this constructor requires another Object3D as parameter, it is a workaround to forbid direct instantiation
			//of the FlarasScene, simulating a Java abstract class behaviour.
			if (this != selfReference)
			{
				throw new IllegalOperationError("Abstract class did not receive reference to itself. FlarasScene class cannot be instantiated directly");
			}
			else
			{
				_parentPoint = parentPoint;
				_translation = translation;
				_rotation = rotation;
				_scale = scale;
				_label = pLabel;
			}
		}
		
		public function destroy():void
		{
			_audio.destroy();
			_audio = null;
			_animation = null;
			
			_parentPoint = null;
			_label = null;
			_translation = null;
			_rotation = null;
			_scale = null;
		}
		
		public function getAnimation():AnimationScene
		{
			return _animation;
		}
		
		public function getAudio():AudioScene
		{
			return _audio;
		}		
		
		public function getTranslation():Number3D
		{
			return _translation;
		}
		
		public function getRotation():Number3D
		{
			return _rotation;
		}
		
		public function getScale():Number3D
		{
			return _scale;
		}
		
		public function getParentPoint():Point
		{
			return _parentPoint;
		}
		
		public function getListOfFilesAndDirs():Vector.<String>
		{
			var listOfFiles:Vector.<String>;
			
			listOfFiles = new Vector.<String>();
			if (_audio)
			{
				listOfFiles.push(FolderConstants.getFlarasAppCurrentFolder() + "/" + _audio.getAudioFilePath());
			}
			
			return listOfFiles;
		}
		
		public function getBaseSceneFilePath():String
		{
			return null;
		}
		
		public function setAnimation(animation:AnimationScene):void 
		{
			_animation = animation;
		}
				
		public function setAudio(audio:AudioScene):void 
		{
			_audio = audio;
		}	
		
		public function setTranslation(translation:Number3D):void
		{
			_translation = translation;
		}
		
		public function setRotation(rotation:Number3D):void
		{
			_rotation = rotation;
		}
		
		public function setScale(scale:Number3D):void
		{
			_scale = scale;
		}
		
		public function getLabel():String 
		{
			return _label;
		}
		
		public function setLabel(pLabel:String):void 
		{
			_label = pLabel;
		}
	}
}
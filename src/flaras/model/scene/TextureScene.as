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
	
	public class TextureScene extends FlarasScene
	{
		private var _textureFilePath:String;
		private var _width:Number;
		private var _height:Number;
		
		public function TextureScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D,textureFilePath:String, width:Number, height:Number)
		{
			super(this, parentPoint, translation, rotation, scale);
			_textureFilePath = textureFilePath;
			_width = width;
			_height = height;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_textureFilePath = null;
		}
		
		public function getTextureFilePath():String { return _textureFilePath; }
		public function getWidth():Number { return _width; }
		public function getHeight():Number { return _height; }
		
		public function setTexturePath(textureFilePath:String):void 
		{
			_textureFilePath = textureFilePath;
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
			listOfFilesAndDirs.push(FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureFilePath);
			
			return listOfFilesAndDirs;
		}
		
		override public function getBaseSceneFilePath():String 
		{
			return FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureFilePath;
		}
	}
}
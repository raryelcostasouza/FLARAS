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

package flaras.model.point
{
	import flaras.*;
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	import org.papervision3d.objects.primitives.*;

	
	public class Point
	{		
		private var _idNumber:uint;
		private var _indexOnList:uint;
		private var _enabled:Boolean;
		private var _indexActiveScene:int = 0;
		private var _indexLastActiveScene:int = 0;
		private var _interactionLock:Boolean = false;
		
		private var _label:String;
		private var _position:Number3D;
		private var _listOfFlarasScenes:Vector.<FlarasScene>;
		private var _moveInteractionForScenes:Boolean;
		
		public function Point(pIndexOnList:uint, pPosition:Number3D, pLabel:String, pMoveInteractionForScenes:Boolean, pIDNumber:uint)
		{
			_listOfFlarasScenes = new Vector.<FlarasScene>();
			
			_label = pLabel;
			_indexOnList = pIndexOnList;
			_enabled = false;
			_position = pPosition;
			_moveInteractionForScenes = pMoveInteractionForScenes;
			
			_idNumber = pIDNumber;
		}
		
		public function destroy():void
		{
			_listOfFlarasScenes = null;
			_label = null;
			_position = null;
		}
		
		public function getIndexActiveScene():int
		{
			return _indexActiveScene;
		}
		
		public function setIndexActiveScene(pIndex:int):void
		{
			_indexActiveScene = pIndex;
		}
		
		public function getIndexLastActiveScene():int
		{
			return _indexLastActiveScene;
		}
		
		public function setIndexLastActiveScene(pIndex:int):void
		{
			_indexLastActiveScene = pIndex;
		}
		
		public function getInteractionLock():Boolean
		{
			return _interactionLock;
		}
		
		public function setInteractionLock(pInteractionLock:Boolean):void
		{
			_interactionLock = pInteractionLock;
		}
		
		public function getIndexOnList():uint
		{
			return _indexOnList;
		}
		
		public function setIndexOnList(pIndexOnList:uint):void
		{
			_indexOnList = pIndexOnList;
		}
		
		public function getIDNumber():uint
		{
			return _idNumber;
		}
		
		public function isEnabled():Boolean
		{
			return _enabled;
		}
		
		public function setEnabled(enable:Boolean):void
		{
			_enabled = enable;
		}
		
		public function getPosition():Number3D
		{
			return _position;
		}
		
		public function setPosition(pPosition:Number3D):void
		{
			_position = pPosition;
		}
		
		public function getLabel():String 
		{
			return _label;
		}
		
		public function setLabel(pLabel:String):void 
		{
			_label = pLabel;
		}
		
		public function isMoveInteractionForScenes():Boolean
		{
			return _moveInteractionForScenes;
		}
		
		public function setMoveInteractionForScenes(pMoveInteractionForScenes:Boolean):void
		{
			_moveInteractionForScenes = pMoveInteractionForScenes;
		}
		
		public function getFilePathListOfObjects():String
		{
			return XMLFilesConstants.LIST_OF_OBJECTS_SEMI_COMPLETE_PATH + getIndexOnList() + ".xml";
		}
		
		public function getListOfFlarasScenes():Vector.<FlarasScene>
		{
			return _listOfFlarasScenes;
		}
	}	
}
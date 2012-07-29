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

package flaras.entity
{
	import flaras.*;
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.entity.object3D.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.util.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	import org.papervision3d.objects.primitives.*;
	
	public class Point
	{		
		private var aID:uint;
		private var aEnabled:Boolean;
		private var aPosition:Number3D;
		
		private var aIndexActiveObject:int = 0;
		private var aIndexLastActiveObject:int = 0;
		private var aInteractionLock:Boolean = false;
		
		private var _listOfObjects:Vector.<Object3D>;
		
		public function Point(pID:uint, pPosition:Number3D)
		{			
			_listOfObjects = new Vector.<Object3D>();
			
			aID = pID;
			aEnabled = false;
			aPosition = pPosition;
		}
		
		public function getIndexActiveObject():int
		{
			return aIndexActiveObject;
		}
		
		public function setIndexActiveObject(pIndex:int):void
		{
			aIndexActiveObject = pIndex;
		}
		
		public function getIndexLastActiveObject():int
		{
			return aIndexLastActiveObject;
		}
		
		public function setIndexLastActiveObject(pIndex:int):void
		{
			aIndexLastActiveObject = pIndex;
		}
		
		public function getInteractionLock():Boolean
		{
			return aInteractionLock;
		}
		
		public function setInteractionLock(pInteractionLock:Boolean):void
		{
			aInteractionLock = pInteractionLock;
		}
		
		public function getID():uint
		{
			return aID;
		}
		
		public function setID(pID:uint):void
		{
			aID = pID;
		}
		
		public function isEnabled():Boolean
		{
			return aEnabled;
		}
		
		public function setEnabled(enable:Boolean):void
		{
			aEnabled = enable;
		}
		
		public function getPosition():Number3D
		{
			return aPosition;
		}
		
		public function getFilePathListOfObjects():String
		{
			return XMLFilesConstants.LIST_OF_OBJECTS_SEMI_COMPLETE_PATH + getID() + ".xml";
		}
		
		public function getListOfObjects():Vector.<Object3D>
		{
			return _listOfObjects;
		}
		
		public function setPosition(pPosition:Number3D):void
		{
			aPosition = pPosition;
		}
	}	
}
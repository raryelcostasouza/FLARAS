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

package flaras.entity.object3D
{
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.marker.*;
	import flash.errors.*;
	import org.papervision3d.objects.*;
	
	public class Object3D
	{
		//this constructor requires another Object3D as parameter as a workaround to forbid direct instantiation
		//of the Object3D simulating a Java abstract class behaviour.
		public function Object3D(pSelf:Object3D)
		{
			if (pSelf != this)
			{
				//only a subclass can pass a valid reference to itself
				throw new IllegalOperationError("Abstract class did not receive reference to itself. Object3D class cannot be instantiated directly");
			}
		}
		
		public function getParentPoint():Point 
		{ 
			throwError();
			return null 
		}
		
		public function setObject3DAlreadyLoaded(pObject3DAlreadyLoaded:Boolean):void 
		{
			throwError();
		}
		
		public function getDisplayObject3D():DisplayObject3D 
		{
			throwError();
			return null 
		}
		public function setDisplayObject3D(pDisplayObject3D:DisplayObject3D):void 
		{
			throwError();
		}
		
		public function enableObject(pPlayAudio:Boolean):void 
		{
			throwError();
		}
		public function disableObject():void
		{
			throwError();
		}
			
		public function updateObject3DPosition():void 
		{
			throwError();
		}
		public function copyDisplayObject3DProperties(aDestination:DisplayObject3D):void 
		{
			throwError();
		}
		public function isObject3DAlreadyLoaded():Boolean 
		{
			throwError();
			return false 
		}
		
		public function setVisible(visible:Boolean):void
		{
			throwError();
		}
		
		public function unLoad():void 
		{
			throwError();
		}
		
		public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{
			throwError();
		}
		
		public function isEnabled():Boolean 
		{ 
			throwError();
			return false 
		}
		
		private function throwError():void
		{
			throw new IllegalOperationError("FLARAS Error: Don't call the methods of the pseudo-abstract class directly. Use the FacadeObject3D");
		}
	}
}
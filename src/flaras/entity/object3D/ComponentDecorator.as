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
	import org.papervision3d.objects.*;
	
	public class ComponentDecorator extends Object3D implements IObject3D
	{		
		private var aComponent:Object3D;
		
		public function ComponentDecorator(pObj3D:Object3D)
		{
			super(this);
			aComponent = pObj3D;
		}
		
		override public function getAnimation():Animation
		{
			return aComponent.getAnimation();
		}
		
		override public function getParentPoint():Point 
		{
			return aComponent.getParentPoint();
		}
		
		override public function setObject3DAlreadyLoaded(pObject3DAlreadyLoaded:Boolean):void 
		{
			aComponent.setObject3DAlreadyLoaded(pObject3DAlreadyLoaded);
		}
		
		override public function getDisplayObject3D():DisplayObject3D 
		{
			return aComponent.getDisplayObject3D();
		}
		
		override public function setDisplayObject3D(pDisplayObject3D:DisplayObject3D):void
		{
			aComponent.setDisplayObject3D(pDisplayObject3D);
		}
		
		override public function enableObject(pPlayAudio:Boolean):void 
		{ 
			aComponent.enableObject(pPlayAudio);
		}
		
		override public function disableObject():void 
		{ 
			aComponent.disableObject();
		}
		
		override public function updateObject3DPosition():void 
		{
			aComponent.updateObject3DPosition();
		}
		
		override public function copyDisplayObject3DProperties(aDestination:DisplayObject3D):void 
		{
			aComponent.copyDisplayObject3DProperties(aDestination);
		}
		
		override public function isObject3DAlreadyLoaded():Boolean 
		{
			return aComponent.isObject3DAlreadyLoaded();
		}
		
		override public function setVisible(visible:Boolean):void
		{
			aComponent.setVisible(visible);
		}
		
		override public function unLoad():void
		{
			aComponent.unLoad();
		}
		
		override public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{
			aComponent.unLoadAndRemoveFile(removeAudio);
		}
		
		override public function isEnabled():Boolean
		{
			return aComponent.isEnabled();
		}
		
		public function getComponent():Object3D
		{
			return aComponent;
		}
	}
}
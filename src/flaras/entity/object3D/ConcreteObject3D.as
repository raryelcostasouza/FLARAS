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
	import flaras.*;
	import flaras.constants.FolderConstants;
	import flaras.controller.CtrMirror;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flash.events.*;
	import flash.utils.Timer;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	
	public class ConcreteObject3D extends Object3D implements IObject3D
	{
		//translation from the object to the parent point
		private var aTranslation:Number3D;
		private var aRotation:Number3D;
		private var aObjParentPoint:Point;
		private var aDisplayObject3D:DisplayObject3D;
		private var aFilePath:String;
		private var aObject3DAlreadyLoaded:Boolean;
		private var _animation:Animation;
				
		public function ConcreteObject3D(pParentPoint:Point, pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
								pScale:Number3D, pAnimation:Animation) 
		{
			super(this);
			
			aObjParentPoint = pParentPoint;
			aFilePath = pFilePath;
			aTranslation = pTranslation;
			aRotation = pRotation;
			
			aDisplayObject3D = new DisplayObject3D();
			aDisplayObject3D.position = Number3D.add(aTranslation, aObjParentPoint.getPosition());
			setRotation(pRotation);
			setScale(pScale);
			
			aObject3DAlreadyLoaded = false;
			_animation = pAnimation;
			_animation.setObj3D(this);
		}
		
		override public function getAnimation():Animation
		{
			return this._animation;
		}
		
		override public function getDisplayObject3D():DisplayObject3D
		{
			return aDisplayObject3D;
		}
		
		override public function setDisplayObject3D(pDisplayObject3D:DisplayObject3D):void
		{
			aDisplayObject3D = pDisplayObject3D;
		}
		
		override public function isObject3DAlreadyLoaded():Boolean
		{
			return aObject3DAlreadyLoaded;
		}
		
		override public function setObject3DAlreadyLoaded(pObject3DAlreadyLoaded:Boolean):void
		{
			aObject3DAlreadyLoaded = pObject3DAlreadyLoaded;
		}
		
		override public function getParentPoint():Point
		{
			return aObjParentPoint;
		}
		
		override public function isEnabled():Boolean
		{
			return aDisplayObject3D.visible;
		}
		
		public function getFilePath():String
		{
			return aFilePath;
		}
		
		public function setFilePath(pFilePath:String):void
		{
			unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
			aFilePath = pFilePath;
			
			aObject3DAlreadyLoaded = false;
		}
		
		public function getTranslation():Number3D
		{
			return aTranslation;
		}
		
		public function setTranslation(pTranslation:Number3D):void
		{
			aTranslation = pTranslation;
			updateObject3DPosition();
		}
		
		public function getRotation():Number3D
		{
			return aRotation;
		}
		
		public function setRotation(pRotation:Number3D):void
		{
			aDisplayObject3D.rotationX = pRotation.x;
			aDisplayObject3D.rotationY = pRotation.y;
			aDisplayObject3D.rotationZ = pRotation.z;
			aRotation = pRotation;
		}
		
		public function getScale():Number3D
		{
			return new Number3D(aDisplayObject3D.scaleX, 
								aDisplayObject3D.scaleY, 
								aDisplayObject3D.scaleZ);
		}
		
		public function setScale(pScale:Number3D):void
		{			
			var positiveScale:Number3D;
			
			positiveScale = new Number3D(Math.abs(pScale.x), Math.abs(pScale.y), Math.abs(pScale.z))
			
			aDisplayObject3D.scaleX = positiveScale.x * CtrMirror.MIRRORED_SCALE_FACTOR;
			aDisplayObject3D.scaleY = positiveScale.y;
			aDisplayObject3D.scaleZ = positiveScale.z;
		}
		
		public function toggleMirror():void
		{
			aDisplayObject3D.scaleX *= -1;
		}
		
		override public function enableObject(pPlayAudio:Boolean):void
		{
			if (!aObject3DAlreadyLoaded)
			{
				load();	
			}
			else
			{
				setVisible(true);
			}
			_animation.startObjectAnimation();			
		}
		
		override public function disableObject():void
		{
			setVisible(false);
			_animation.stopObjectAnimation();
		}
		
		override public function setVisible(visible:Boolean):void
		{
			aDisplayObject3D.visible = visible;
		}
			
		private function load():void
		{
			aObject3DAlreadyLoaded = true;
			
			var objKMZ:KMZ = new KMZ();
			objKMZ.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			objKMZ.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			
			objKMZ.load(FolderConstants.getFlarasAppCurrentFolder()+"/"+aFilePath);		
			
			copyDisplayObject3DProperties(objKMZ);
			aDisplayObject3D = objKMZ;
			
			MarkerNodeManager.addObj2MarkerNode(aDisplayObject3D, Marker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			setObject3DAlreadyLoaded(false);
			_animation.stopObjectAnimation();
			aDisplayObject3D.removeEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			aDisplayObject3D.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			MarkerNodeManager.removeObjFromMarkerNode(aDisplayObject3D, Marker.REFERENCE_MARKER);
		}
		
		override public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{
			unLoad();			
			FileRemover.removeFile(FolderConstants.getFlarasAppCurrentFolder()+"/"+aFilePath);			
		}
		
		override public function updateObject3DPosition():void
		{
			aDisplayObject3D.position = Number3D.add(aTranslation, aObjParentPoint.getPosition());
		}
		
		override public function copyDisplayObject3DProperties(aDestination:DisplayObject3D):void
		{
			aDestination.position = aDisplayObject3D.position;
			
			aDestination.rotationX = aDisplayObject3D.rotationX;
			aDestination.rotationY = aDisplayObject3D.rotationY;
			aDestination.rotationZ = aDisplayObject3D.rotationZ;
			
			aDestination.scaleX = aDisplayObject3D.scaleX;
			aDestination.scaleY = aDisplayObject3D.scaleY;
			aDestination.scaleZ = aDisplayObject3D.scaleZ;
		}
	}
}
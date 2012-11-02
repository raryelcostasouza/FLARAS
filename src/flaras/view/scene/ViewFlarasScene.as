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

package flaras.view.scene 
{
	import flaras.controller.*;
	import flaras.controller.util.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.core.render.data.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.view.*;
	import org.papervision3d.view.layer.*;
	
	public class ViewFlarasScene 
	{
		private var _viewAudio:ViewAudioScene;
		private var _viewAnimation:ViewAnimationScene;
		
		protected var _obj3D:DisplayObject3D;
		private var _baseFlarasScene:FlarasScene;
		private var _ctrMain:CtrMain;	
		private var _obj3DLayer:ViewportLayer;
		private var _dragPlane:Plane;
		private var _dragging:Boolean;
		private var _viewport:Viewport3D;
		
		public function ViewFlarasScene(selfReference:ViewFlarasScene, baseFlarasScene:FlarasScene, pCtrMain:CtrMain) 
		{
			if (this != selfReference)
			{
				throw new IllegalOperationError("Abstract class did not receive reference to itself. ViewFlarasScene class cannot be instantiated directly");
			}
			else
			{
				_ctrMain = pCtrMain;
				_baseFlarasScene = baseFlarasScene;
			}
		}
		
		public function getObj3D():DisplayObject3D
		{
			return _obj3D;
		}
		
		public function getViewAudio():ViewAudioScene
		{
			return _viewAudio;
		}
		
		public function getViewAnimation():ViewAnimationScene
		{
			return _viewAnimation;
		}
		
		public function getBaseFlarasScene():FlarasScene
		{
			return _baseFlarasScene;
		}
		
		public function setViewAnimation(viewAnimation:ViewAnimationScene):void
		{
			_viewAnimation = viewAnimation;
		}
		
		public function setViewAudio(viewAudio:ViewAudioScene):void
		{
			_viewAudio = viewAudio;
		}
		
		public function showScene(playAudio:Boolean):void
		{
			if (_viewAudio && playAudio)
			{
				_viewAudio.showScene();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.showScene();
			}			
		}
		
		public function hideScene():void
		{			
			if (_viewAudio)
			{
				_viewAudio.hideScene();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.hideScene();
			}
		}
		
		public function resetScenePosition():void
		{
			_obj3D.position = Number3D.add(_baseFlarasScene.getTranslation(), _baseFlarasScene.getParentPoint().getPosition());
		}
		
		protected function setObj3DProperties(flarasScene:FlarasScene, obj3D:DisplayObject3D):void
		{
			var rotation:Number3D;
			var scale:Number3D;
			
			obj3D.position = Number3D.add(flarasScene.getTranslation(), flarasScene.getParentPoint().getPosition());
			
			rotation = flarasScene.getRotation();
			obj3D.rotationX = rotation.x;
			obj3D.rotationY = rotation.y;
			obj3D.rotationZ = rotation.z;
			
			scale = flarasScene.getScale();
			obj3D.scaleX = scale.x;
			obj3D.scaleY = scale.y;
			obj3D.scaleZ = scale.z;			
		}
		
		public function setTranslation(translation:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.position = Number3D.add(translation, _baseFlarasScene.getParentPoint().getPosition());
			}			
		}
		
		public function reloadPointPosition():void
		{
			if (_obj3D)
			{
				_obj3D.position = Number3D.add(_baseFlarasScene.getTranslation(), _baseFlarasScene.getParentPoint().getPosition());
			}			
		}
		
		public function setRotation(rotation:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.rotationX = rotation.x;
				_obj3D.rotationY = rotation.y;
				_obj3D.rotationZ = rotation.z;
			}
		}
		
		public function setScale(scale:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.scaleX = scale.x;
				_obj3D.scaleY = scale.y;
				_obj3D.scaleZ = scale.z;				
			}
		}
		
		public function setMirrorScaleFactor(mirrorScaleFactor:int):void
		{
			if (_obj3D)
			{
				_obj3D.scaleX *= mirrorScaleFactor;
			}
		}
		
		public function toggleMirror():void
		{
			if (_obj3D)
			{
				_obj3D.scaleX *= -1;
			}			
		}
		
		public function unLoad():void
		{
			if (_viewAudio)
			{
				_viewAudio.unLoad();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.unLoad();
			}
		}
		
		public function destroyAudio():void
		{
			if (_viewAudio)
			{
				_viewAudio.unLoad();
				setViewAudio(null);
			}
		}
		
		public function unLoadAudio():void
		{
			_viewAudio.unLoad();
		}
		
		public function destroy():void
		{
			if (_obj3DLayer)
			{
				_obj3DLayer.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				_obj3DLayer.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				_obj3DLayer.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			
			if (_dragPlane)
			{
				_dragPlane = null;
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.destroy();
			}
			
			if (_viewAudio)
			{
				_viewAudio.destroy();
			}
		}
		
		protected function setupMouseInteraction():void
		{			
			_viewport = _ctrMain.fmmapp.getViewPort();
			_obj3DLayer = _viewport.containerSprite.getChildLayer(_obj3D, true, true);
			_obj3DLayer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_obj3DLayer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_obj3DLayer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			_dragPlane = new Plane(new ColorMaterial(0x00FF00, 0), 1500, 1500, 6, 6);
			_dragPlane.material.doubleSided = true;
			_dragging = false;
		}

		public function setupMoveInteraction():void
		{
			if (!_dragging)
			{
				_dragging = true;
				StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, stopDrag);
				
				_dragPlane.material.interactive = true;
				
				_dragPlane.copyPosition(_obj3D);
				MarkerNodeManager.addObj2MarkerNode(_dragPlane, CtrMarker.REFERENCE_MARKER, null);
				StageReference.getStage().addEventListener(Event.ENTER_FRAME, drag);
			}
		}
		
		private function drag(e:Event):void
		{
			var rh:RenderHitData;
			var eulerAngles:Number3D; 
			var mousePosRelative2RefMarker:Number3D;
			var refMarkerPosRelative2Camera:Number3D; 
			
			//copy the object position to the plane
			_dragPlane.copyPosition(_obj3D);
			
			//return the 3d coordinates of the point where the mouse hits the 3D plane
			rh = _viewport.hitTestPoint2D(new Point(_viewport.containerSprite.mouseX, _viewport.containerSprite.mouseY));
			
			//check if happened a collision with the invisible plane
			if (rh.hasHit && rh.displayObject3D == _dragPlane)
			{
				//get the ref. marker position relative to the camera
				refMarkerPosRelative2Camera = MarkerNodeManager.getPosition(CtrMarker.REFERENCE_MARKER);
				
				//vector mousePosRelative2RefMarker + vector refMarkerPosRelative2Camera = vector rh
				//so... vector mousePosRelative2RefMarker = vector rh - vector refMarkerPosRelative2Camera
				mousePosRelative2RefMarker = Number3D.sub(new Number3D(rh.x, rh.y, rh.z), refMarkerPosRelative2Camera);
				
				//get euler angles to convert the coordinates to the ref marker reference system
				eulerAngles = org.papervision3d.core.math.Matrix3D.matrix2euler(MarkerNodeManager.getWorldTransfMatrix(CtrMarker.REFERENCE_MARKER));

				//apply the rotations...
				mousePosRelative2RefMarker.rotateX(eulerAngles.x);
				mousePosRelative2RefMarker.rotateY(eulerAngles.y);
				mousePosRelative2RefMarker.rotateZ(eulerAngles.z);
			
				//drag the object in the XY plane
				_obj3D.x = mousePosRelative2RefMarker.x;
				_obj3D.y = mousePosRelative2RefMarker.y;
			}			
		}
		
		private function stopDrag(e:Event):void
		{
			_dragging = false;
			_dragPlane.material.interactive = false;
			
			MarkerNodeManager.removeObjFromMarkerNode(_dragPlane, CtrMarker.REFERENCE_MARKER);
			
			StageReference.getStage().removeEventListener(Event.ENTER_FRAME, drag);
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, stopDrag);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			e.currentTarget.filters = [new GlowFilter(0xcccc00, 1, 20, 20, 5)];
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_ctrMain.ctrInteraction.mouseClickScene(_baseFlarasScene.getParentPoint(), this);
		}
	}
}
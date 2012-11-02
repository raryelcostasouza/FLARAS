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
	import flaras.controller.util.StageReference;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.Point;
	import org.libspark.flartoolkit.support.pv3d.FLARBaseNode;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.math.*;
	import org.papervision3d.core.render.data.RenderHitData;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.layer.*;
	import org.papervision3d.view.Viewport3D;
	
	public class ViewFlarasScene 
	{
		private var _viewAudio:ViewAudioScene;
		private var _viewAnimation:ViewAnimationScene;
		
		protected var _obj3D:DisplayObject3D;
		private var _baseFlarasScene:FlarasScene;
		private var _ctrMain:CtrMain;	
		private var _obj3DLayer:ViewportLayer;
		
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
			_obj3DLayer.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_obj3DLayer.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_obj3DLayer.removeEventListener(MouseEvent.CLICK, onMouseClick);
			_obj3DLayer.removeEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
			
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
			_obj3DLayer = _ctrMain.fmmapp.getViewPort().containerSprite.getChildLayer(_obj3D, true, true);
			_obj3DLayer.addEventListener(MouseEvent.CLICK, onMouseClick);
			_obj3DLayer.addEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
			_obj3DLayer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_obj3DLayer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			//_obj3DLayer.addEventListener(MouseEvent.MOUSE_DOWN, startDrag);
			//StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, stopDrag);
		}
		
		/*public var dragPlane:Plane = new Plane(new ColorMaterial(0x00FF00, 1), 200, 200, 6, 6);
		private var isdrag:Boolean = false;
		
		private function stopDrag(e:Event):void
		{
			isdrag = false;
			StageReference.getStage().removeEventListener(Event.ENTER_FRAME, frame);
		}
		
		private function startDrag(e:Event):void
		{
			if (!isdrag)
			{
				isdrag = true;
				
				dragPlane.material.interactive = true;
				dragPlane.material.doubleSided = true;
				dragPlane.y = 100;
				MarkerNodeManager.addObj2MarkerNode(dragPlane, 0, null);
				

				
				StageReference.getStage().addEventListener(Event.ENTER_FRAME, frame);
				//frame(null);
			}			
		}
		
		private function frame(e:Event):void
		{
			var viewport:Viewport3D;
			
			dragPlane.copyPosition(_obj3D);
			
			viewport = _ctrMain.fmmapp.getViewPort();
			var rh:RenderHitData = viewport.hitTestPoint2D(new Point(viewport.containerSprite.mouseX, viewport.containerSprite.mouseY));
			//subtrair coordenadas marcador 
			if (rh.hasHit)
			{
				trace("---");
				trace("RH:", rh.x, rh.y, rh.z);
				
				var refMarkerPos:Number3D = _ctrMain.fmmapp.getRefMarker().position;
				trace("REF:", refMarkerPos.x, refMarkerPos.y, refMarkerPos.z);
				var sub:Number3D = Number3D.sub(new Number3D(rh.x, rh.y, rh.z), refMarkerPos);
				trace("SUB:", sub.x, sub.y, sub.z);
				
				
				var angulosEuler:Number3D = Matrix3D.matrix2euler(MarkerNodeManager.getWorldTransfMatrix(CtrMarker.REFERENCE_MARKER));
				trace("EULER:", angulosEuler.z)

				sub.rotateX(angulosEuler.x);
				sub.rotateY(angulosEuler.y);
				sub.rotateZ(angulosEuler.z);
				trace("SUB_ROT:", sub.x, sub.y, sub.z);
				_obj3D.x = sub.x;
				_obj3D.y = sub.y;
			}			
		}*/
		
		private function onMouseOver(e:MouseEvent):void
		{
			e.currentTarget.filters = [new GlowFilter(0xcccc00, 1, 20, 20, 5)];
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			if (_ctrMain.ctrMarker.getModelInteractionMarker().getMarkerType() == CtrMarker.INSPECTOR_MARKER)
			{
				_ctrMain.ctrPoint.inspectPoint(_baseFlarasScene.getParentPoint());
			}
			else
			{
				_ctrMain.ctrPoint.controlPoint(_baseFlarasScene.getParentPoint(), _ctrMain.ctrMarker.getModelInteractionMarker().getControlMarkerType());
			}
		}		
		
		private function onMouseRightClick(e:MouseEvent):void
		{
			_ctrMain.ctrPoint.controlPoint(_baseFlarasScene.getParentPoint(), CtrMarker.CONTROL_BACKWARD);
		}
	}
}
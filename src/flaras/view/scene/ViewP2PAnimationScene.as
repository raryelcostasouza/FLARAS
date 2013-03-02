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
	import flaras.controller.util.*;
	import flaras.model.scene.*;
	import flash.events.*;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.objects.*;
	public class ViewP2PAnimationScene extends ViewAnimationScene
	{
		private var _animationScene:P2PAnimationScene;
		
		private var _obj3DToAnimate:DisplayObject3D;
		private var _running:Boolean;
		private var _frameRate:Number;
		private var _step:Number3D;
		private var _startPointPosition:Number3D;
		
		public function ViewP2PAnimationScene(pP2PAnimationScene:P2PAnimationScene, pViewFlarasScene:ViewFlarasScene) 
		{
			super(pViewFlarasScene);
			_animationScene = pP2PAnimationScene;
			
			initAnimVars();
		}
		
		private function initAnimVars():void
		{
			_obj3DToAnimate = _viewFlarasScene.getObj3D();
			_running = false;
			_frameRate = StageReference.getStage().frameRate;
		}
		
		override public function showScene():void
		{
			var velocity:Number3D;
			
			if (!_running)
			{
				initAnimVars();
				
				//animation displacement is relative to the scene translation
				velocity = Number3D.sub(Number3D.add(_animationScene.getDisplacement(), getCurrentTranslation()), getCurrentTranslation());
				velocity.x = velocity.x / (1.0 * _animationScene.getTime());
				velocity.y = velocity.y / (1.0 * _animationScene.getTime());
				velocity.z = velocity.z / (1.0 * _animationScene.getTime());
			
				_step = new Number3D(velocity.x * 1.0 / _frameRate, velocity.y * 1.0 / _frameRate, velocity.z * 1.0 / _frameRate);
				
				//startPointPosition is only used while using moving interaction
				if (_startPointPosition == null)
				{
					_obj3DToAnimate.position = getCurrentTranslation();
				}
				else
				{
					_obj3DToAnimate.position = _startPointPosition;
				}				
				
				StageReference.getStage().addEventListener(Event.ENTER_FRAME, animation);
				_running = true;				
			}
		}
		
		override public function hideScene():void
		{
			if (_running)
			{
				_running = false;
				StageReference.getStage().removeEventListener(Event.ENTER_FRAME, animation);
			}
		}	
		
		private function animation(e:Event):void
		{	
			if (!hasArrivedAtDestination())
			{
				_obj3DToAnimate.position = Number3D.add(_step, _obj3DToAnimate.position);
			}
			else
			{
				//if the animation loop is disabled
				if (!_animationScene.hasLoop())
				{
					//stop the animation
					hideScene();
				}
				else
				{
					//restart the animation
					hideScene();
					showScene();
				}				
			}
		}
		
		private function hasArrivedAtDestination():Boolean
		{
			var xObj:int;
			var yObj:int;
			var zObj:int;
			var xDestInteger:int;
			var yDestInteger:int;
			var zDestInteger:int;
			
			xObj = int(Math.round(_obj3DToAnimate.x));
			yObj = int(Math.round(_obj3DToAnimate.y));
			zObj = int(Math.round(_obj3DToAnimate.z));
			
			//startPointPosition is only used while using moving interaction
			if (_startPointPosition == null)
			{
				xDestInteger = int(Math.round(getCurrentTranslation().x+_animationScene.getDisplacement().x));
				yDestInteger = int(Math.round(getCurrentTranslation().y+_animationScene.getDisplacement().y));
				zDestInteger = int(Math.round(getCurrentTranslation().z+_animationScene.getDisplacement().z));			
			}
			else
			{
				xDestInteger = int(Math.round(_startPointPosition.x+_animationScene.getDisplacement().x));
				yDestInteger = int(Math.round(_startPointPosition.y+_animationScene.getDisplacement().y));
				zDestInteger = int(Math.round(_startPointPosition.z+_animationScene.getDisplacement().z));
			}
			
				
			if (xObj == xDestInteger && 
				yObj == yDestInteger && 
				zObj == zDestInteger)
			{
				return true;
			}
			else
			{
				return false;
			}			
		}
		
		//startPointPosition is only used while using moving interaction
		public function setStartPointPosition(pPosition:Number3D):void
		{
			_startPointPosition = pPosition;
		}
		
		override public function unLoad():void
		{
			_running = false;
			StageReference.getStage().removeEventListener(Event.ENTER_FRAME, animation);
			
			if (_obj3DToAnimate)
			{
				_obj3DToAnimate.x = getCurrentTranslation().x;
				_obj3DToAnimate.y = getCurrentTranslation().y;
				_obj3DToAnimate.z = getCurrentTranslation().z;
			}		
		}
		
		override public function destroy():void
		{
			unLoad();
			_obj3DToAnimate = null;
			_animationScene = null;
			_viewFlarasScene = null;
		}
	}
}
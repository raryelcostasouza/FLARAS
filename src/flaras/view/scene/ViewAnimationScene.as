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
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.events.*;
	import flash.utils.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	
	public class ViewAnimationScene
	{
		public static const X_ROTATION_AXIS:uint = 0;
		public static const Y_ROTATION_AXIS:uint = 1;
		public static const Z_ROTATION_AXIS:uint = 2;
		
		private var _viewFlarasScene:ViewFlarasScene;
		private var _animationScene:AnimationScene;
		private var _obj3DToAnimate:DisplayObject3D;
		
		private var _increaseAngleStep:Number;
		private var _angSumDegree:Number;
		private var _running:Boolean;
		private var _frameRate:Number;
		
		public function ViewAnimationScene(animationScene:AnimationScene, viewFlarasScene:ViewFlarasScene)
		{
			_animationScene = animationScene;
			_viewFlarasScene = viewFlarasScene;
			
			initAnimVars();
		}
		
		private function initAnimVars():void
		{
			_obj3DToAnimate = _viewFlarasScene.getObj3D();
			_running = false;
			_frameRate = StageReference.getStage().frameRate;
		}
		
		public function showScene():void
		{
			if (_animationScene.getPeriod() != 0 && !_running)
			{
				initAnimVars();
				
				//360º                - period (s)
				//increaseAngleStep   - 1.0/_frameRate (seconds) - (1 frame)
				_increaseAngleStep = _animationScene.getRotationDirection() * (360 * 1.0 / _frameRate) / _animationScene.getPeriod();
				_angSumDegree = 0;
				
				StageReference.getStage().addEventListener(Event.ENTER_FRAME, animation);
				_running = true;
			}
		}
		
		public function hideScene():void
		{
			if (_running)
			{
				_running = false;
				StageReference.getStage().removeEventListener(Event.ENTER_FRAME, animation);
			}
		}
		
		private function animation(e:Event):void
		{
			var angSumRad:Number;
			
			_angSumDegree += _increaseAngleStep;
			angSumRad = _angSumDegree * Math.PI / 180.0;
			
			if (_animationScene.getRotationAxis() == X_ROTATION_AXIS)
			{
				_obj3DToAnimate.x = _viewFlarasScene.getPosRotationCenter().x;
				_obj3DToAnimate.y = _viewFlarasScene.getPosRotationCenter().y + _animationScene.getRadiusA() * Math.cos(angSumRad);
				_obj3DToAnimate.z = _viewFlarasScene.getPosRotationCenter().z + _animationScene.getRadiusB() * Math.sin(angSumRad);
				
				_obj3DToAnimate.rotationX = getCurrentRotation().x + _angSumDegree;
			}
			else if (_animationScene.getRotationAxis() == Y_ROTATION_AXIS)
			{
				_obj3DToAnimate.x = _viewFlarasScene.getPosRotationCenter().x + _animationScene.getRadiusA() * Math.cos(angSumRad);
				_obj3DToAnimate.y = _viewFlarasScene.getPosRotationCenter().y;
				_obj3DToAnimate.z = _viewFlarasScene.getPosRotationCenter().z + _animationScene.getRadiusB() * Math.sin(angSumRad);
				
				_obj3DToAnimate.rotationY = getCurrentRotation().y + _angSumDegree;
			}
			else
			{
				_obj3DToAnimate.x = _viewFlarasScene.getPosRotationCenter().x + _animationScene.getRadiusA() * Math.cos(angSumRad);
				_obj3DToAnimate.y = _viewFlarasScene.getPosRotationCenter().y + _animationScene.getRadiusB() * Math.sin(angSumRad);
				_obj3DToAnimate.z = _viewFlarasScene.getPosRotationCenter().z;
				
				_obj3DToAnimate.rotationZ = getCurrentRotation().z + _angSumDegree;
			}
		}
		
		public function unLoad():void
		{
			_running = false;
			StageReference.getStage().removeEventListener(Event.ENTER_FRAME, animation);
			
			if (_obj3DToAnimate)
			{
				_obj3DToAnimate.rotationX = getCurrentRotation().x;
				_obj3DToAnimate.rotationY = getCurrentRotation().y;
				_obj3DToAnimate.rotationZ = getCurrentRotation().z;
				
				_obj3DToAnimate.x = getCurrentTranslation().x;
				_obj3DToAnimate.y = getCurrentTranslation().y;
				_obj3DToAnimate.z = getCurrentTranslation().z;
			}		
		}
		
		public function destroy():void
		{
			unLoad();
			_obj3DToAnimate = null;
			_animationScene = null;
			_viewFlarasScene = null;
		}
		
		private function getCurrentTranslation():Number3D
		{
			return Number3D.add(_viewFlarasScene.getBaseFlarasScene().getTranslation(), _viewFlarasScene.getBaseFlarasScene().getParentPoint().getPosition());
		}
		
		private function getCurrentRotation():Number3D
		{
			return _viewFlarasScene.getBaseFlarasScene().getRotation();
		}
	}
}
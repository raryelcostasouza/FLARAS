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
	import flaras.util.*;
	import flash.events.*;
	import flash.utils.Timer;
	import org.papervision3d.objects.*;

	public class Animation 
	{
		public static const X_ROTATION_AXIS:uint = 0;
		public static const Y_ROTATION_AXIS:uint = 1;
		public static const Z_ROTATION_AXIS:uint = 2;
		
		private var _hasAnimation:Boolean;
		private var _period:Number;
		private var _rotationAxis:uint;
		
		private var increaseAngleStep:Number;
		private var obj3DToAnimate:DisplayObject3D;
		private var timer:Timer;
		
		private var _concreteObj3D:ConcreteObject3D;
		
		public function Animation(hasAnimation:Boolean, period:Number, rotationAxis:uint):void
		{
			this._hasAnimation = hasAnimation;
			this._period = period;
			this._rotationAxis = rotationAxis;
		}
		
		public function setObj3D(concreteObj3D:ConcreteObject3D):void
		{
			this._concreteObj3D = concreteObj3D;
		}
		
		public function startObjectAnimation():void
		{	
			if (this._hasAnimation && _period != 0)
			{
				timer = new Timer(33); //30 fps... 1 frap aprox every 33 ms
			
				obj3DToAnimate = _concreteObj3D.getDisplayObject3D();
		
				//360º                - period (s)
				//increaseAngleStep   - 0.033 (s) (1 frame)
				increaseAngleStep = (360 * 0.03) / _period;
				
				timer.addEventListener(TimerEvent.TIMER, animation);
				timer.start();
			}			
		}
		
		private function animation(e:Event):void
		{
			if (_rotationAxis == X_ROTATION_AXIS)
			{
				obj3DToAnimate.rotationX += increaseAngleStep;
			}
			else if (_rotationAxis == Y_ROTATION_AXIS)
			{
				obj3DToAnimate.rotationY += increaseAngleStep;
			}
			else
			{
				obj3DToAnimate.rotationZ += increaseAngleStep;
			}
		}
		
		public function stopObjectAnimation():void
		{
			if (timer != null)
			{
				timer.removeEventListener(TimerEvent.TIMER, animation);
				timer.stop();
				timer = null;
				
				obj3DToAnimate.rotationX = _concreteObj3D.getRotation().x;
				obj3DToAnimate.rotationY = _concreteObj3D.getRotation().y;
				obj3DToAnimate.rotationZ = _concreteObj3D.getRotation().z;
			}
			
		}
		
		public function getHasAnimation():Boolean
		{
			return this._hasAnimation
		}
		
		public function getPeriod():Number
		{
			return this._period
		}
		
		public function getRotationAxis():uint
		{
			return this._rotationAxis
		}
		
		public function setHasAnimation(hasAnimation:Boolean):void
		{
			this._hasAnimation = hasAnimation;
		}
		
		public function setPeriod(period:Number):void
		{
			this._period = period;
		}
		
		public function setRotationAxis(rotationAxis:uint):void
		{
			this._rotationAxis = rotationAxis;
		}		
	}
}
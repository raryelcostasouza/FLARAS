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

package flaras.model.scene 
{
	public class AnimationScene 
	{
		private var _period:Number;
		private var _rotationAxis:uint;
		private var _radiusA:Number;
		private var _radiusB:Number;
		private var _rotationDirection:int;
		
		public function AnimationScene(period:Number, rotationAxis:uint, radiusA:Number, radiusB:Number, rotationDirection:int) 
		{
			_period = period;
			_rotationAxis = rotationAxis;
			_radiusA = radiusA;
			_radiusB = radiusB;
			_rotationDirection = rotationDirection;
		}
		
		public function getPeriod():Number { return _period; }
		public function getRotationAxis():uint { return _rotationAxis; }
		public function getRadiusA():Number { return _radiusA; }
		public function getRadiusB():Number { return _radiusB; }		
		public function getRotationDirection():int { return _rotationDirection; }
		
		public function setAnimationProperties(period:Number, rotationAxis:uint, radiusA:Number, radiusB:Number, rotationDirection:int):void
		{
			_period = period;
			_rotationAxis = rotationAxis;
			_radiusA = radiusA;
			_radiusB = radiusB;
			_rotationDirection = rotationDirection;
		}
		
		public function clone():AnimationScene
		{
			var clone:AnimationScene;
			
			clone = new AnimationScene(_period, _rotationAxis, _radiusA, _radiusB, _rotationDirection);
			
			return clone;
		}
	}
}
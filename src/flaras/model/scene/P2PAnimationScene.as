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
	import org.papervision3d.core.math.*;
	
	public class P2PAnimationScene extends AnimationScene
	{
		private var _displacement:Number3D;
		private var _time:Number;
		private var _hasLoop:Boolean;
		
		//point to point animation
		public function P2PAnimationScene(pDisplacement:Number3D, pTime:Number, pLoop:Boolean) 
		{
			_displacement = pDisplacement;
			_time = pTime;
			_hasLoop = pLoop;
		}
		
		public function getDisplacement():Number3D
		{
			return _displacement;
		}
		
		public function getTime():Number
		{
			return _time;
		}
		
		public function hasLoop():Boolean
		{
			return _hasLoop;
		}		
		
		public function setAnimationProperties(pDisplacement:Number3D, pTime:Number, pHasLoop:Boolean):void
		{
			_displacement = pDisplacement;
			_time = pTime;
			_hasLoop = pHasLoop;
		}
	}
}
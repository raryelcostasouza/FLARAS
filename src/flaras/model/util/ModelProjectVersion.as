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

package flaras.model.util 
{
	public class ModelProjectVersion 
	{
		private var _release:uint;
		private var _subRelease:uint;
		private var _bugFix:uint;		
		
		public function ModelProjectVersion(pRelease:uint, pSubRelease:uint, pBugFix:uint) 
		{
			this._release = pRelease;
			this._subRelease = pSubRelease;
			this._bugFix = pBugFix;
		}
		
		public function getRelease():uint { return _release; }
		public function getSubRelease():uint { return _subRelease; }
		public function getBugFix():uint { return _bugFix; }
		
		public function getHashSum():uint
		{
			return 8 * _release + 4 * _subRelease + 2 * _bugFix;
		}
		
		public function toString():String
		{
			return _release + "." + _subRelease + "." + _bugFix;
		}
	}

}
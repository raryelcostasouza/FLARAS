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
	import org.papervision3d.core.math.*;
	public class ViewAnimationScene
	{
		protected var _viewFlarasScene:ViewFlarasScene;
		
		public function ViewAnimationScene(pViewFlarasScene:ViewFlarasScene)
		{
			_viewFlarasScene = pViewFlarasScene;
		}
		
		public function showScene():void
		{
			
		}
		
		public function hideScene():void
		{
			
		}
		
		public function unLoad():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
		protected function getCurrentTranslation():Number3D
		{
			return Number3D.add(_viewFlarasScene.getBaseFlarasScene().getTranslation(), _viewFlarasScene.getBaseFlarasScene().getParentPoint().getPosition());
		}
	}
}
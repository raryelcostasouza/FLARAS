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
	import flaras.controller.audio.*;
	import flaras.controller.constants.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	
	public class ViewAudioScene 
	{
		private var _audioScene:AudioScene;
				
		public function ViewAudioScene(audioScene:AudioScene) 
		{
			_audioScene = audioScene;
		}
		
		public function showScene():void
		{
			AudioManager.playAppAudio(FolderConstants.getFlarasAppCurrentFolder()+ "/"+ _audioScene.getAudioFilePath(), _audioScene.getRepeatAudio(), _audioScene.getParentPointID());
		}
		
		public function hideScene():void
		{
			unLoad();
		}		
		
		public function unLoad():void
		{
			AudioManager.stopAppAudio(_audioScene.getParentPointID());
		}		
		
		public function destroy():void
		{
			unLoad();
			_audioScene = null;
		}
	}
}
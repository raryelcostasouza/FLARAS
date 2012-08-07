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

package flaras.controller.audio
{	
	public class  AudioManager
	{
		private static var aIDPoint:uint = 0;
		//ID of the point which is playing the current app audio file
		
		//2 audio channels: one for FLARAS sounds and other for application sounds
		private static var aObjAppAudioPlayer:AudioPlayer;
		private static var aObjSystemAudioPlayer:AudioPlayer;		
		
		public static function playAppAudio(pFilePath:String, pRepeatAudio:Boolean, pIDPoint:uint):void
		{
			if (aObjAppAudioPlayer != null)
			{	
				aObjAppAudioPlayer.destroy();	
			}
			aObjAppAudioPlayer = new AudioPlayer(pFilePath, pRepeatAudio);
			aIDPoint = pIDPoint;
		}
		
		public static function stopAppAudio(pIDPoint:uint):void
		{
			if ((aObjAppAudioPlayer != null) && (aIDPoint == pIDPoint))
			{
				aObjAppAudioPlayer.destroy();
				aObjAppAudioPlayer = null;
			}
		}
		
		public static function playSystemAudio(pFilePath:String):void
		{
			if (aObjSystemAudioPlayer != null)
			{
				aObjSystemAudioPlayer.destroy();
			}
			aObjSystemAudioPlayer = new AudioPlayer(pFilePath, false);
		}
	}	
}
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
	import flaras.controller.*;
	import flaras.controller.io.*;
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;

    public class AudioPlayer
	{
        private var aFilePath:String;
        private var aObjSound:Sound;
        private var aObjSoundChannel:SoundChannel;
        private var aRepeatAudioAfterEnd:Boolean;

        public function AudioPlayer(pFilePath:String, pRepeatAudioAfterEnd:Boolean) 
		{
			aRepeatAudioAfterEnd = pRepeatAudioAfterEnd;
			aFilePath = pFilePath;
			
			aObjSound = new Sound(new URLRequest(aFilePath));	
			aObjSound.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);
			aObjSound.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			aObjSound.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			playAudio();
        }
		
		public function playAudio():void
		{
			aObjSoundChannel = aObjSound.play();
			aObjSoundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundPlayingComplete);			
		}
		
		public function destroy():void
		{
			aObjSoundChannel.stop();
			aObjSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundPlayingComplete);
		}

		private function onSoundPlayingComplete(event:Event):void 
		{
			//if the audio has to repeat after it ends
			if (aRepeatAudioAfterEnd)
			{
				aObjSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundPlayingComplete);
				playAudio();
			}
		}		
	}
}
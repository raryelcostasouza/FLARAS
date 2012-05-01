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
	import flaras.audio.*;
	import flaras.constants.FolderConstants;
	import flaras.entity.*;
	import flaras.io.*;
	
	public class AudioDecorator extends ComponentDecorator
	{
		private var aAudioPath:String;
		private var aRepeatAudio:Boolean;
		
		public static const REMOVE_AUDIO_FILE:Boolean = true;
		public static const DONT_REMOVE_AUDIO_FILE:Boolean = false;
		
		public function AudioDecorator(pObj3D:Object3D, pAudioPath:String, pRepeatAudio:Boolean) 
		{
			super(pObj3D);
			aAudioPath = pAudioPath;
			aRepeatAudio = pRepeatAudio;
		}
		
		override public function enableObject(pPlayAudio:Boolean):void
		{
			super.enableObject(pPlayAudio);
			if (pPlayAudio)
			{
				var objParentPoint:Point = getParentPoint();
				AudioManager.playAppAudio(FolderConstants.getFlarasAppCurrentFolder()+ "/"+ aAudioPath, aRepeatAudio, objParentPoint.getID());
			}
		}
		
		override public function disableObject():void
		{
			super.disableObject();
			AudioManager.stopAppAudio(getParentPoint().getID());
		}

		public function getAudioPath():String
		{
			return aAudioPath;
		}
		
		public function setAudioPath(pAudioPath:String):void
		{
			AudioManager.stopAppAudio(getParentPoint().getID());
			removeAudioFile();
			aAudioPath = pAudioPath;
		}
		
		public function getRepeatAudio():Boolean
		{
			return aRepeatAudio;
		}
		
		public function setRepeatAudio(pRepeatAudio:Boolean):void
		{
			aRepeatAudio = pRepeatAudio;
		}
		
		override public function unLoad():void
		{
			super.unLoad();
			AudioManager.stopAppAudio(getParentPoint().getID());
		}
		
		override public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{
			super.unLoadAndRemoveFile(removeAudio);
			
			unLoad();
			if (removeAudio)
			{
				removeAudioFile();
			}			
		}
		
		public function removeAudioFile():void
		{
			FileRemover.removeFile(FolderConstants.getFlarasAppCurrentFolder()+ "/"+ aAudioPath);
		}
	}
}
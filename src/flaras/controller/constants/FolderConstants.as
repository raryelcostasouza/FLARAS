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

package flaras.controller.constants 
{
	public class FolderConstants
	{
		public static const AUDIO_FOLDER:String = "audios/";
		public static const COLLADA_FOLDER:String = "dae/";
		public static const TEXTURE_FOLDER:String = "textures/";
		public static const VIDEO_FOLDER:String = "videos/";
		public static const XML_FOLDER:String = "xml/";
		
		public static const TEMPLATE_PUBLISH_FOLDER:String = "template-publish/";
		
		public static const DATA_FOLDER:String = "Data/";
		public static const ICONS_FOLDER:String = "icons/";
		public static const SYSTEM_AUDIOS_FOLDER:String = "system-audios/";
		public static const SYSTEM_TEXTURES_FOLDER:String = "system-textures/";
		
		public static const FLARASAPP_FOLDER:String = FOLDER_NAME_FLARASAPP+ "/";
		public static const FLARASAPPDATA_FOLDER:String = FLARASAPP_FOLDER + "flarasAppData/";
		
		public static const FOLDER_NAME_FLARASAPP:String = "flarasApp";
		
		//when working on FLARAS Developer, it's the temp folder
		private static var flarasAppCurrentFolder:String;
		public static function setFlarasAppCurrentFolder(folderPath:String):void
		{
			flarasAppCurrentFolder = folderPath;
		}
		
		public static function getFlarasAppCurrentFolder():String
		{
			return flarasAppCurrentFolder;
		}		
	}
}
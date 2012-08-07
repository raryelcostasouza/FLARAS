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

package flaras.controller.io 
{
	import flaras.*;
	import flaras.constants.*;
	import flaras.controller.constants.*;
	import flash.filesystem.*;
	import flash.utils.*;
	import nochump.util.zip.*;
	
	public class ProjectPublisher 
	{
		public static function publishProject(pCurrentTmpFolder:File):ByteArray
		{		
			var ba:ByteArray;
			var folders2Zip:Vector.<File>;
			//copy the template to the temp folder
			FileCopy.copyFolder(File.applicationDirectory.resolvePath(FolderConstants.TEMPLATE_PUBLISH_FOLDER), pCurrentTmpFolder, FolderConstants.FOLDER_NAME_FLARASAPP);
			
			//copying project files to the template folder
			var folders2Copy:Vector.<File> = new Vector.<File>();
			folders2Copy.push(pCurrentTmpFolder.resolvePath(FolderConstants.AUDIO_FOLDER));
			folders2Copy.push(pCurrentTmpFolder.resolvePath(FolderConstants.COLLADA_FOLDER));
			folders2Copy.push(pCurrentTmpFolder.resolvePath(FolderConstants.TEXTURE_FOLDER));
			folders2Copy.push(pCurrentTmpFolder.resolvePath(FolderConstants.VIDEO_FOLDER));
			folders2Copy.push(pCurrentTmpFolder.resolvePath(FolderConstants.XML_FOLDER));
			
			FileCopy.copyMultipleFolders2SameDestination(folders2Copy, pCurrentTmpFolder.resolvePath(FolderConstants.FLARASAPPDATA_FOLDER));
														
			//zip the flarasApp folder
			folders2Zip = new Vector.<File>();
			folders2Zip.push(pCurrentTmpFolder.resolvePath(FolderConstants.FLARASAPP_FOLDER));
			ba = Zip.generateZipFileFromFolders(folders2Zip);
			
			removeFlarasAppFolder(pCurrentTmpFolder);
			
			return ba;
		}
		
		private static function removeFlarasAppFolder(tmpFolder:File):void
		{
			var f:File = tmpFolder.resolvePath(FolderConstants.FLARASAPP_FOLDER);
			f.deleteDirectory(true);
		}
	}
}
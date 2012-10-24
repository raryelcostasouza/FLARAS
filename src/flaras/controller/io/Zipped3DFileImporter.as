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
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flash.errors.*;
	import flash.filesystem.*;
	
	public class Zipped3DFileImporter 
	{
		public static function importFile(zipFile:File):String
		{
			var flarasTempFolder:File = new File(FolderConstants.getFlarasAppCurrentFolder());
			var fileDestinationSubFolder:File;
			var newFilePath:String;
			var strFolderExtractedFile:String;
			var obj3DFileFound:File;
			
			fileDestinationSubFolder = flarasTempFolder.resolvePath(FolderConstants.COLLADA_FOLDER);
			strFolderExtractedFile = Zip.unzipToFileNameFolder(zipFile, fileDestinationSubFolder);
			obj3DFileFound = FileUtil.recursiveSearch3DFile(fileDestinationSubFolder.resolvePath(strFolderExtractedFile));
			
			if (obj3DFileFound != null)
			{
				newFilePath = FolderConstants.COLLADA_FOLDER + fileDestinationSubFolder.getRelativePath(obj3DFileFound);
			}
			else
			{
				newFilePath = null;
			}				
			
			try
			{
				zipFile.deleteFile();
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("Zipped3DFileImporter", zipFile.nativePath);
			}
			catch (sE:SecurityError)
			{
				ErrorHandler.onSecurityError("Zipped3DFileImporter", zipFile.nativePath);
			}
			
			//if the extracted file has invalid characters
			if (!FileUtil.hasValidFileName(newFilePath))
			{
				//rename the 3d object file to a valid default name
				newFilePath = renameObj3DFile(newFilePath);
			}
			
			return newFilePath;
		}
		
		//get the folderpath of the folder to which the ZIP file was extracted
		public static function get3DFileExtractedFolder(daeFilePath:File):File
		{
			var daeProjectFolder:File;
			var relativePath:String;
			var indexFirstSlash:uint;
			var extractedFolderName:String;
			var extractedFolderPath:File;
			
			daeProjectFolder = new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + FolderConstants.COLLADA_FOLDER);
			
			relativePath = daeProjectFolder.getRelativePath(daeFilePath);
			indexFirstSlash = relativePath.indexOf("/");
			extractedFolderName = relativePath.slice(0, indexFirstSlash);
			
			extractedFolderPath = new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + FolderConstants.COLLADA_FOLDER + extractedFolderName);
			
			return extractedFolderPath;
		}
		
		private static function renameObj3DFile(pOldPathTo3DFile:String):String
		{
			var newPathTo3DFile:String;
			var parentFolder:File;
			var oldFile:File;
			var newFile:File;
			var fileExtension:String;
			
			//old file with invalid characters
			oldFile = new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + pOldPathTo3DFile);
			fileExtension = oldFile.extension;
			parentFolder = oldFile.parent;
			
			newFile = parentFolder.resolvePath("obj3dFile." + fileExtension);
			oldFile.moveTo(newFile, true);
			
			newPathTo3DFile = new File(FolderConstants.getFlarasAppCurrentFolder()).getRelativePath(newFile);
			
			return newPathTo3DFile;
		}
	}
}
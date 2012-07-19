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

package flaras.io 
{
	import flaras.constants.*;
	import flaras.errorHandler.*;
	import flash.errors.*;
	import flash.filesystem.*;
	
	public class KMZ2DAEImporter 
	{
		public static function importZipped3DFile(kmzFile:File):String
		{
			var flarasTempFolder:File = new File(FolderConstants.getFlarasAppCurrentFolder());
			var fileDestinationSubFolder:File;
			var newFilePath:String;
			var strFolderExtractedFile:String;
			var daeFile:File;
			var max3dsFile:File;
			
			fileDestinationSubFolder = flarasTempFolder.resolvePath(FolderConstants.COLLADA_FOLDER);
			strFolderExtractedFile = Zip.unzipToFileNameFolder(kmzFile, fileDestinationSubFolder);
			daeFile = FileSearch.recursiveSearch3DFile(fileDestinationSubFolder.resolvePath(strFolderExtractedFile));
			/*max3dsFile = FileSearch.recursiveSearch3DFile(fileDestinationSubFolder.resolvePath(strFolderExtractedFile), "3ds");
			max3dsFile = FileSearch.recursiveSearch3DFile(fileDestinationSubFolder.resolvePath(strFolderExtractedFile), "max");*/
			
			if (daeFile != null)
			{
				newFilePath = FolderConstants.COLLADA_FOLDER + fileDestinationSubFolder.getRelativePath(daeFile);
			}
			else
			{
				newFilePath = null;
			}				
			
			try
			{
				kmzFile.deleteFile();
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOErrorSynchronous(ioE, kmzFile.nativePath);
			}
			catch (sE:SecurityError)
			{
				ErrorHandler.onSecurityErrorSynchronous(sE, kmzFile.nativePath);
			}
			
			return newFilePath;
		}
		
		//get the folderpath of the folder to which the KMZ/ZIP file was extracted
		public static function getDAEFileExtractedFolder(daeFilePath:File):File
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
	}
}
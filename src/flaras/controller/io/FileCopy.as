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
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.view.gui.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	
	public class FileCopy 
	{
		private static var fileDestinationSubFolder:File;
		private static var aCtrGUI:CtrGUI;
		private static var aDestinationSubFolder:String;
		
		public static function audioCopy(pCurrentProjectTempFolder:File, pCtrGUI:CtrGUI):void
		{
			aCtrGUI = pCtrGUI;
			aDestinationSubFolder = FolderConstants.AUDIO_FOLDER;
			copy(new FileFilter("Audio MP3 Files", "*.mp3"), pCurrentProjectTempFolder, "Get audio file");
		}
		
		public static function colladaCopy(pCurrentProjectTempFolder:File, pCtrGUI:CtrGUI):void
		{
			aCtrGUI = pCtrGUI;
			aDestinationSubFolder = FolderConstants.COLLADA_FOLDER;
			copy(new FileFilter("DAE/3DS zipped Files (.zip) or KMZ Files (.kmz)", "*.zip;*.kmz;"), pCurrentProjectTempFolder, "Get Collada file");
		}
		
		public static function textureCopy(pCurrentProjectTempFolder:File, pCtrGUI:CtrGUI):void
		{
			aCtrGUI = pCtrGUI;
			aDestinationSubFolder = FolderConstants.TEXTURE_FOLDER;
			copy(new FileFilter("Image Files (.jpg, .gif or .png)", "*.jpg;*.gif;*.png"), pCurrentProjectTempFolder, "Get texture file");
		}
		
		public static function videoCopy(pCurrentProjectTempFolder:File, pCtrGUI:CtrGUI):void
		{
			aCtrGUI = pCtrGUI;
			aDestinationSubFolder = FolderConstants.VIDEO_FOLDER;
			copy(new FileFilter("Video Files (.mp4 or .flv)", "*.mp4;*.flv"), pCurrentProjectTempFolder, "Get video file");
		}
		
		private static function copy(pFileFilter:FileFilter, pCurrentProjectTempFolder:File, pTitleMessage:String):void
		{
			var fileSource:File = new File();
			
			fileSource.addEventListener(Event.SELECT, fileSelected);			
			fileDestinationSubFolder = pCurrentProjectTempFolder.resolvePath(aDestinationSubFolder);
			
			try
			{
				fileSource.browseForOpen(pTitleMessage, [pFileFilter]);
			}
			catch (ioe:IllegalOperationError)
			{
				//the user tried to open to browseForOpen operations
				//nothing is necessary to be done... just ignoring the error
			}
		}	
		
		private static function fileSelected(e:Event):void
		{
			var f:File;
			var fileSource:File;
			var strFolderExtractedFile:String;
			var daeFile:File;
			var path:String;
			var indexFileExtensionDot:uint;
			var fileNameWithoutExtension:String;
			var validFileName:String;
			
			fileSource = File(e.target);
			fileSource.removeEventListener(Event.SELECT, fileSelected);
						
			f = new File(fileDestinationSubFolder.resolvePath(fileSource.name).nativePath);
			
			//check if the filename contain invalid characters
			if (!FileUtil.hasValidFileName(f.name))
			{
				//if it has invalid characters, rename it removing the invalid chars!
				f = renameFileWithInvalidChar(f);
			}
			
			fileNameWithoutExtension = FileUtil.getFileNameWithoutExtension(f);	
			
			// if there is another file/folder with the same name
			if ((f.exists && !isObj3DFile(f)) ||
				//extracted folder already exists
				(f.parent.resolvePath(fileNameWithoutExtension).exists) && isObj3DFile(f))
			{
				validFileName = generateFileNameWithUniqueSuffix(fileSource, fileDestinationSubFolder, isObj3DFile(f));
				f = new File(fileDestinationSubFolder.resolvePath(validFileName).nativePath);
				fileNameWithoutExtension = FileUtil.getFileNameWithoutExtension(f);
			}
			else
			{
				validFileName = f.name;
			}
			
			try
			{
				fileSource.copyTo(f, false);
				
				//if it was selected a 3d model file
				if (isObj3DFile(f))
				{
					//unzip the file and get the path to the file
					path = Zipped3DFileImporter.importFile(fileDestinationSubFolder.resolvePath(validFileName));
					
					//if it is a invalid dae/3ds file
					if (path == null)
					{
						MessageWindow.messageInvalidDAEFile();
						//remove the extracted folder
						FileRemover.remove(f.parent.resolvePath(fileNameWithoutExtension).nativePath);
					}
					else
					{
						aCtrGUI.finishedFileCopying(path, aDestinationSubFolder);	
					}
				}
				//if it was copied a texture, video or audio
				else
				{
					aCtrGUI.finishedFileCopying(aDestinationSubFolder+validFileName, aDestinationSubFolder);	
				}
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("FileCopy", f.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("FileCopy", f.nativePath);
			}	
		}
		
		public static function copyFolder(folder2Copy:File, destinationFolder:File, pCopiedFolderNewName:String = ""):void
		{
			var fileList:Array = folder2Copy.getDirectoryListing();
			var folder2Create:File;
			
			// variable used to rename the copied folder
			var folderName:String;
			
			if (pCopiedFolderNewName == "")
			{
				folderName = folder2Copy.name;
			}
			else
			{
				folderName = pCopiedFolderNewName;
			}
						
			// creates the destination folder
			folder2Create = destinationFolder.resolvePath(folderName);
			
			try
			{
				folder2Create.createDirectory();
			
				//copies each item of the folder
				for each(var f:File in fileList)
				{
					f.copyTo(destinationFolder.resolvePath(folderName + "/" + f.name));
				}	
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("FileCopy", f.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("FileCopy", f.nativePath);
			}					
		}
		
		public static function copyMultipleFolders2SameDestination(folders2Copy:Vector.<File>, destinationFolder:File):void
		{
			for each (var f:File in folders2Copy) 
			{
				copyFolder(f, destinationFolder);
			}
		}
		
		private static function isObj3DFile(file:File):Boolean
		{
			return (file.extension.toLowerCase() == "kmz" || file.extension.toLowerCase() == "zip");
		}	
		
		private static function getFileNameFromPath(path:String):String
		{
			var indexOfLastSlash:uint;
			
			
			indexOfLastSlash = path.lastIndexOf("/");
			return path.slice(indexOfLastSlash + 1, path.length);		
		}
		
		private static function generateFileNameWithUniqueSuffix(pF:File, destFolder:File, is3DObj:Boolean):String
		{
			var nSuffix:uint;
			var fileNameWithoutExtension:String;
			var name:String;
			var f:File;
			
			fileNameWithoutExtension = FileUtil.getFileNameWithoutExtension(pF);
			nSuffix = 0;
			do
			{
				if (is3DObj)
				{
					if (!pF.isDirectory)
					{
						//check if there is another folder with the obj3d file name without the extension
						f = new File(destFolder.resolvePath(fileNameWithoutExtension + nSuffix).nativePath);
						name = f.name + "." + pF.extension;
					}
					else
					{
						//if the file reference is a directory, don't need to add any extension to the new name
						f = new File(destFolder.resolvePath(fileNameWithoutExtension + nSuffix).nativePath);
						name = f.name;
					}					
				}
				else
				{
					f = new File(destFolder.resolvePath(fileNameWithoutExtension + nSuffix + "." + pF.extension).nativePath);
					name = f.name;
				}
				
				nSuffix++;
			}while (f.exists);	
			
			return name; 
		}
		
		private static function renameFileWithInvalidChar(pOldFile:File):File
		{
			var oldFileName:String;
			var newFile:File;
			var newFileName:String;
			var char:String;
			var parentFolder:File;
			
			oldFileName = pOldFile.name;
			newFileName = new String();
			for (var i:uint = 0; i < oldFileName.length; i++ )
			{
				char = oldFileName.charAt(i);
				//only add to the new file name the following ascii characters: a-z, A-Z, 0-9, _, - and .
				if ((char >= "a" && char <= "z") ||
					(char >= "A" && char <= "Z") ||
					(char >= "0" && char <= "9") ||
					(char == "_") || 
					(char == ".") || 
					(char == "-"))
				{
					newFileName = newFileName.concat(char);
				}
			}
			
			parentFolder = pOldFile.parent;
			
			newFile = parentFolder.resolvePath(newFileName);
			
			return newFile;
		}
		
		//creates a copy of  file, with a unique name on the folder
		public static function copyUniqueName(f:File, isObj3DFile:Boolean):String
		{
			var newUniqueName:String;
			var folderExtracted3DObj:File;
			var relativePath3DFile:File;

			try
			{
				if (!isObj3DFile)
				{
					newUniqueName = generateFileNameWithUniqueSuffix(f, f.parent, false);
					f.copyTo(f.parent.resolvePath(newUniqueName), false);
				}
				else
				{
					folderExtracted3DObj = Zipped3DFileImporter.get3DFileExtractedFolder(f);
					newUniqueName = generateFileNameWithUniqueSuffix(folderExtracted3DObj, new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + FolderConstants.COLLADA_FOLDER), true);
					//copy the complete folder where the 3d file was extracted to the folder with the unique name generated above
					folderExtracted3DObj.copyTo(new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + FolderConstants.COLLADA_FOLDER + newUniqueName), false);
					
					//the complete filepath to the obj3d file is the folder name (generated above) concatenated with the path to the dae/3ds file 
					newUniqueName += "/"+folderExtracted3DObj.getRelativePath(f);
				}	
				
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("FileCopy", f.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("FileCopy", f.nativePath);
			}			
			
			return newUniqueName;
		}
		
	}
}
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
	import flaras.*;
	import flaras.constants.*;
	import flaras.errorHandler.*;
	import flaras.userInterface.*;
	import flaras.userInterface.graphicUserInterfaceComponents.*;
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
			copy(new FileFilter("DAE zipped Files (.zip) or KMZ Files (.kmz)", "*.zip;*.kmz"), pCurrentProjectTempFolder, "Get Collada file");
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
			fileSource.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			fileSource.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			fileSource.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);
			
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
			
			fileSource = File(e.target);
			fileSource.removeEventListener(Event.SELECT, fileSelected);
						
			f = new File(fileDestinationSubFolder.resolvePath(fileSource.name).nativePath);
			
			indexFileExtensionDot = f.name.lastIndexOf(".");
			fileNameWithoutExtension = f.name.slice(0, indexFileExtensionDot);	
			
			// if there is no other file/folder with the same name
			if ((!f.exists && !isObj3DFile(f)) || 
				//extracted folder does not exist
				(!f.parent.resolvePath(fileNameWithoutExtension).exists) && isObj3DFile(f))
			{
				try
				{
					fileSource.copyTo(fileDestinationSubFolder.resolvePath(fileSource.name), false);
					
					//if it was selected a 3d model file
					if (isObj3DFile(f))
					{
						path = KMZ2DAEImporter.importKMZ(fileDestinationSubFolder.resolvePath(fileSource.name));
						
						if (path == null)
						{
							MessageWindow.messageInvalidDAEFile();
						}
						else
						{
							aCtrGUI.finishedFileCopying(path, aDestinationSubFolder);	
						}
					}
					//if it was copied a texture, video or audio
					else
					{
						path = fileSource.name;
						aCtrGUI.finishedFileCopying(aDestinationSubFolder+path, aDestinationSubFolder);	
					}
				}
				catch (ioE:IOError)
				{
					ErrorHandler.onIOErrorSynchronous(ioE, f.nativePath);
				}
				catch (se:SecurityError)
				{
					ErrorHandler.onSecurityErrorSynchronous(se, f.nativePath);
				}
			}
			else
			{
				MessageWindow.messageFileAlreadyExists(fileSource.name);
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
				ErrorHandler.onIOErrorSynchronous(ioE, f.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityErrorSynchronous(se, f.nativePath);
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
	}
}
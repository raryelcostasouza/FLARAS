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

package flaras.controller 
{
	import flaras.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.controller.io.fileSaver.*;
	import flaras.controller.video.*;
	import flaras.model.point.*;
	import flaras.view.gui.*;
	import flash.desktop.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class CtrUserProject 
	{
		private static const ACTION_NEW_PROJECT:int = 0;
		private static const ACTION_OPEN_PROJECT:int = 1;
		private static const ACTION_CLOSE_FLARAS:int = 2;
		
		/* aAlreadySavedBefore is false when there was no saving operation for this project, just for new projects
		   aAlreadySavedBefore is true when the user already selected the destination of the XXX.flaras project file
		   if the project was loaded this variable will always be true*/
		private var aAlreadySavedBefore:Boolean;
		private var aSaveAsRequested:Boolean;
		private var aCurrentProjectTempFolder:File;
		private var aProjectFile:File;
		private var _actionAfterSaving:int = -1;
		private var _ctrMain:CtrMain;
		private var _overwriteSituation:OverwriteSituation;
		
		// used to check if there are any unsaved modifications on the project before exitting, opening a new
		// project or creating a new project.
		private var _unSavedModifications:Boolean;
		private var _filePathCurrentIOOperation:String;
		
		public function CtrUserProject(ctrMain:CtrMain) 
		{
			_ctrMain = ctrMain;
			
			//listener for cleaning temp files when exiting the application
			NativeApplication.nativeApplication.activeWindow.addEventListener(Event.CLOSING, onWindowClosing);
			
			//listener for checking if the application should load a project directly or just create a new project
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		//function to test if the app is being called from a project file or from the binary file 
		private function onInvoke(io:InvokeEvent):void
		{
			var directory:File;
			var file2Open:File;
				
			// if the app was called from the project file, open it directly
			if (io.currentDirectory != null && io.arguments.length > 0)
			{
				directory = io.currentDirectory;
				file2Open = directory.resolvePath(io.arguments[0]);
				openProjectFromFileDirectly(file2Open);
			}
			//default policy is to create a new project on FLARAS initialization
			else
			{
				actionNewProject();
			}
		}
		
		
		//functions related to FLARAS closing procedure--------------------------------------------------------
		private function onWindowClosing(e:Event = null):void
		{
			e.preventDefault();
			closingFlaras();
		}
		
		public function closingFlaras():void
		{
			if (_unSavedModifications)
			{
				MessageWindow.messageSaveBeforeAction(closeFlarasAndSave, closeFlarasWithoutSaving);
			}
			else
			{
				closeFlarasWithoutSaving(null);
			}			
		}
		
		private function closeFlarasAndSave(e:Event):void
		{
			this._actionAfterSaving = ACTION_CLOSE_FLARAS;
			saveProject();
		}
		
		private function closeFlarasWithoutSaving(e:Event):void
		{
			actionCloseFlaras();
		}
		
		private function actionCloseFlaras():void
		{
			VideoManager.closeStream();
			removeTmpFiles();
			NativeApplication.nativeApplication.exit();
		}
		//end of functions related to FLARAS closing procedure--------------------------------------------------------
		
		public function getCurrentProjectTempFolder():File
		{
			return aCurrentProjectTempFolder;
		}
		
		//functions related with new project creation -------------------------------------------------------
		public function createNewProject():void
		{
			if (_unSavedModifications)
			{
				MessageWindow.messageSaveBeforeAction(saveBeforeNewProject, dontSaveBeforeNewProject);
			}
			else 
			{
				dontSaveBeforeNewProject(null);
			}			
		}
		
		private function saveBeforeNewProject(e:Event):void
		{
			this._actionAfterSaving = ACTION_NEW_PROJECT;
			saveProject();
		}
		
		private function dontSaveBeforeNewProject(e:Event):void
		{
			actionNewProject();
		}
		
		private function actionNewProject():void
		{
			aAlreadySavedBefore = false;
			setUnsavedModifications(false);
			
			if (aCurrentProjectTempFolder != null)
			{
				removeTmpFiles();
				_ctrMain.ctrPoint.destroyListOfPoints();
			}
			
			_ctrMain.ctrMarker.resetBaseType();
			_ctrMain.ctrMarker.resetInteractionMarkerSphereProperties();
			aCurrentProjectTempFolder = File.createTempDirectory();
			initTempSubFolders();
			
			
			_ctrMain.ctrGUI.resetInterface();	
			
			
			_ctrMain.ctrMarker.resetInteractionMarkerSphereProperties();
			FolderConstants.setFlarasAppCurrentFolder(aCurrentProjectTempFolder.url);
			trace(aCurrentProjectTempFolder.nativePath);
		}
		
		private function initTempSubFolders():void
		{
			var subFolders:Vector.<String> = new Vector.<String>;
			
			subFolders.push(FolderConstants.XML_FOLDER);
			subFolders.push(FolderConstants.COLLADA_FOLDER);
			subFolders.push(FolderConstants.AUDIO_FOLDER);
			subFolders.push(FolderConstants.VIDEO_FOLDER);
			subFolders.push(FolderConstants.TEXTURE_FOLDER);
			
			for each (var item:String in subFolders) 
			{
				try
				{
					aCurrentProjectTempFolder.resolvePath(item).createDirectory();
				}
				catch (ioE:IOError)
				{
					ErrorHandler.onIOError("CtrUserProject", aCurrentProjectTempFolder.resolvePath(item).nativePath);
				}
				catch (se:SecurityError)
				{
					ErrorHandler.onSecurityError("CtrUserProject", aCurrentProjectTempFolder.resolvePath(item).nativePath);
				}
			}
		}
		// end of functions related with new project creation -------------------------------------------------------
		
		//functions related with opening a project -----------------------------------------------------------------
		public function openProject():void
		{
			if (_unSavedModifications)
			{
				MessageWindow.messageSaveBeforeAction(saveProjectBeforeOpenProject, dontSaveProjectBeforeOpenProject);
			}
			else
			{
				dontSaveProjectBeforeOpenProject(null);
			}			
		}

		private function saveProjectBeforeOpenProject(e:Event):void
		{
			this._actionAfterSaving = ACTION_OPEN_PROJECT;
			saveProject();
		}
		
		private function dontSaveProjectBeforeOpenProject(e:Event):void
		{
			actionOpenProject();
		}
		
		private function actionOpenProject():void
		{
			var fileProject2Open:File;
			
			actionNewProject();
			
			fileProject2Open = new File();
			fileProject2Open.addEventListener(Event.SELECT, onFile2OpenSelect);
			fileProject2Open.browseForOpen("Open FLARAS Project", [new FileFilter("FLARAS Project Files (.flaras)", "*.flaras")]);
		}
		
		private function onFile2OpenSelect(e:Event):void
		{
			var file2Open:File;
			
			e.target.removeEventListener(Event.SELECT, onFile2OpenSelect);
			
			file2Open = File(e.target);
			
			loadOpenProjectData(file2Open);
		}
		
		//used when the app is called directly from the project file
		private function loadOpenProjectData(file2Open:File):void
		{
			//extracts the zip file to the tmp folder
			
			Zip.unzipFile(file2Open, getCurrentProjectTempFolder());
			
			//stores the file pointer to the opened project file
			aProjectFile = file2Open;
			aAlreadySavedBefore = true;
			
			//read info about the interaction sphere
			_ctrMain.ctrMarker.loadRefMarkerData();
			_ctrMain.ctrMarker.loadInteractionMarkerData();
			
			//load the list of points and list of objects
			_ctrMain.ctrPoint.loadProjectData();
		}
		
		private function openProjectFromFileDirectly(file2Open:File):void
		{
			actionNewProject();
			loadOpenProjectData(file2Open);
		}
		
		// end of functions related with opening a project -----------------------------------------------------------------
		
		public function saveProject():void
		{
			var listOfPoints:Vector.<Point>;
			var ba:ByteArray;
			var fs:FileStream;
			var folders2Zip:Vector.<File>;
			var file2Save:File;
			
			FileSaver.saveInteractionSphereProperties(getCurrentProjectTempFolder(), _ctrMain.ctrMarker.getModelInteractionMarker());
			FileSaver.saveRefMarkerProperties(getCurrentProjectTempFolder(), _ctrMain.ctrMarker.getModelRefMarker());
			
			listOfPoints = _ctrMain.ctrPoint.getListOfPoints();
			FileSaver.saveListOfPoints(listOfPoints, getCurrentProjectTempFolder());
			
			for each (var p:Point in listOfPoints)
			{
				FileSaver.saveListOfObjects(p.getListOfFlarasScenes(), getCurrentProjectTempFolder(), p.getFilePathListOfObjects());
			}
			
			folders2Zip = new Vector.<File>();
			folders2Zip.push(getCurrentProjectTempFolder().resolvePath(FolderConstants.XML_FOLDER));
			folders2Zip.push(getCurrentProjectTempFolder().resolvePath(FolderConstants.COLLADA_FOLDER));
			folders2Zip.push(getCurrentProjectTempFolder().resolvePath(FolderConstants.AUDIO_FOLDER));
			folders2Zip.push(getCurrentProjectTempFolder().resolvePath(FolderConstants.VIDEO_FOLDER));
			folders2Zip.push(getCurrentProjectTempFolder().resolvePath(FolderConstants.TEXTURE_FOLDER));			
			
			//creating the project file (byte array)
			ba = Zip.generateZipFileFromFolders(folders2Zip);
			
			// if it's the first time that the project is being saved to a .flaras file
			if (!aAlreadySavedBefore)
			{
				//ask the user where to save
				file2Save = new File(File.userDirectory.resolvePath("flarasProject.flaras").nativePath);
				file2Save.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				file2Save.addEventListener(Event.COMPLETE, onProjectSavingComplete);
				file2Save.addEventListener(Event.CANCEL, onProjectSavingCancel);
				file2Save.save(ba);
			}
			else
			{
				//save automatically on the last place that the user saved the .flaras file
				try
				{					
					fs = new FileStream();
					fs.open(aProjectFile, FileMode.WRITE);
					fs.writeBytes(ba);
					fs.close();
					MessageWindow.messageSaveSuccess();
				}
				catch (ioE:IOError)
				{
					ErrorHandler.onIOError("CtrUserProject", aProjectFile.nativePath);
				}
				catch (se:SecurityError)
				{
					ErrorHandler.onSecurityError("CtrUserProject", aProjectFile.nativePath);
				}
				
				runActionAfterSaving();
			}
		}
		
		private function onProjectSavingCancel(e:Event):void
		{
			if (aSaveAsRequested)
			{
				aAlreadySavedBefore = true;
			}
		}
		
		private function onProjectSavingComplete(e:Event):void
		{
			var file2Save:File = File(e.target);
			file2Save.removeEventListener(Event.COMPLETE, onProjectSavingComplete);
			file2Save.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			aProjectFile = file2Save;
			aSaveAsRequested = false;
			
			aAlreadySavedBefore = true;
			MessageWindow.messageSaveSuccess();
			
			runActionAfterSaving();
		}
		
		private function runActionAfterSaving():void
		{
			var fixedProjectFile:File;
			
			setUnsavedModifications(false);
			
			fixedProjectFile = forceSavedFileExtension(aProjectFile, ".flaras");
			
			
			//updates the project file pointer with the extension modification
			aProjectFile = fixedProjectFile;
			
			switch(this._actionAfterSaving)
			{
				case ACTION_CLOSE_FLARAS:
					actionCloseFlaras();
					break;
				case ACTION_NEW_PROJECT:
					actionNewProject();
					break;
				case ACTION_OPEN_PROJECT:
					actionOpenProject();
					break;
			}
			this._actionAfterSaving = -1;
		}
		
		public function saveProjectAs():void
		{
			aSaveAsRequested = true;
			aAlreadySavedBefore = false;
			saveProject();
		}
		
		public function publishProject():void
		{
			var ba:ByteArray;
			var publishFile:File;
			
			if (!aAlreadySavedBefore)
			{
				MessageWindow.messageProjectNotSaved2Publish();
			}
			else
			{
				//save the project before publishing to avoid the possibility of publishing the app with unsaved modifications
				saveProject();
				
				ba = ProjectPublisher.publishProject(aCurrentProjectTempFolder);
				
				publishFile = File.userDirectory.resolvePath("flarasApp.zip");
				publishFile.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				publishFile.addEventListener(Event.COMPLETE, onProjectPublishingComplete);
				publishFile.save(ba);
			}			
		}
		
		private function onProjectPublishingComplete(e:Event):void
		{
			var publishFile:File = File(e.target);
			
			publishFile.removeEventListener(Event.COMPLETE, onProjectPublishingComplete);
			publishFile.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			forceSavedFileExtension(publishFile, ".zip");			
		}
	
		private function removeTmpFiles():void
		{
			try
			{
				aCurrentProjectTempFolder.deleteDirectory(true);
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("CtrUserProject", aCurrentProjectTempFolder.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("CtrUserProject", aCurrentProjectTempFolder.nativePath);
			}			
		}
		
		//fileExtension2Force: examples: ".zip", ".flaras", ".xml", etc
		private function forceSavedFileExtension(savedFile:File, fileExtension2Force:String):File
		{
			var fileName:String;
			var savedFileExtension:String;
			var newName:String;
			var destination:File;
			
			//if the file extension is ok, the destination is the same as the source.
			destination = savedFile;
			fileName = savedFile.name;
			
			//stores the last fileExtension2Force.length characters of the fileName, in order to compare them with the
			//expected extension to force.
			savedFileExtension = fileName.toLowerCase().substring(fileName.length-fileExtension2Force.length); 
						
			
			// if the file does not have the needed file extension (fileExtension2Force)
			if (savedFileExtension!=fileExtension2Force)
			{
				newName = savedFile.name + fileExtension2Force;
				//add the extension to the file.
				destination = savedFile.parent.resolvePath(newName);
				
				try
				{
					//if the destination file already exists ask the user if he want to overwrite it
					if (destination.exists)
					{
						this._overwriteSituation = new OverwriteSituation(savedFile, destination, fileExtension2Force);
						MessageWindow.messageOverwriteConfirmation(confirmOverwrite, cancelOverwrite, destination.name, destination.parent.nativePath);
					}
					else
					{
						savedFile.moveTo(destination);
					}
				}
				catch (ioE:IOError)
				{
					ErrorHandler.onIOError("CtrUserProject", savedFile.nativePath);
				}
				catch (se:SecurityError)
				{
					ErrorHandler.onSecurityError("CtrUserProject", savedFile.nativePath);
				}				
			}
			
			return destination;
		}
		
		private function confirmOverwrite(e:Event):void
		{
			try
			{
				this._overwriteSituation.FileSource.moveTo(this._overwriteSituation.FileDestination, true);
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("CtrUserProject", this._overwriteSituation.FileSource.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("CtrUserProject", this._overwriteSituation.FileSource.nativePath);
			}
		}
		
		private function cancelOverwrite(e:Event):void
		{
			this._overwriteSituation.FileSource.deleteFile();
			
			switch(_overwriteSituation.FileExtension)
			{
				case ".zip":
					publishProject();
					break;
				case ".flaras": 
					saveProjectAs();
					break;
			}
		}
		
		public function setUnsavedModifications(unSavedModifications:Boolean):void
		{
			this._unSavedModifications = unSavedModifications;
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("CtrUserProject", _filePathCurrentIOOperation);
		}	
	}
}
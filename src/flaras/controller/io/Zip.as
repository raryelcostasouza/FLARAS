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
	import flaras.view.gui.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.*;
	import nochump.util.zip.*;
	
	public class Zip
	{			
		public static function generateZipFileFromFolders(folders:Vector.<File>):ByteArray
		{			
			var zipOut:ZipOutput;
			var ba:ByteArray;
			
			zipOut = new ZipOutput();
			
			try
			{
				for each(var f:File in folders)
				{
					recZipFolder(zipOut, f, f.name+"/");
				}
				
				zipOut.finish();				
				ba = zipOut.byteArray;
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("Zip", f.nativePath);
				ba = null;
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("Zip", f.nativePath);
				ba = null;
			}
			catch (e:Error)
			{
				ErrorHandler.onGenericError("Zip", e.message);
				ba = null;
			}			
			
			return ba;
		}
		
		private static function recZipFolder(pZipOut:ZipOutput, folder:File, fullPath:String):void
		{
			var ba:ByteArray;
			var fs:FileStream;
			var ze:ZipEntry;
			
			fs = new FileStream();
			for each(var f:File in folder.getDirectoryListing())
			{
				//if the entry is a directory, zip it recursively
				if (f.isDirectory)
				{
					recZipFolder(pZipOut, f, fullPath + f.name + "/");
				}
				//if the entry is a file
				else
				{
					// if the file is not empty, add it to the zip file
					if (f.size > 0)
					{
						//loading file f to ByteArray
						ba = new ByteArray();
						fs.open(f, FileMode.READ);
						fs.readBytes(ba);
						fs.close();
						
						//creating zip entry
						ze = new ZipEntry(fullPath + f.name);
						pZipOut.putNextEntry(ze);
						pZipOut.write(ba);
						pZipOut.closeEntry();
					}					
				}				
			}
			
			// if the folder is empty just creates an empty folder entry at the zip file
			if (folder.getDirectoryListing().length == 0)
			{
				ze = new ZipEntry(fullPath);
				pZipOut.putNextEntry(ze);
				pZipOut.closeEntry();
			}
		}	
		
		//functions for unzipping files ----------------------------------------------------------------		
		public static function unzip(baZipFile:ByteArray, destinationFolder2ExtractFiles:File):void
		{
			var ba:ByteArray;
			var fs:FileStream;
			var fDestination:File;
			var zipFile:ZipFile;
			
			zipFile = new ZipFile(baZipFile);
			
			// for each file on the project
			// extract to the correct place
			for each(var ze:ZipEntry in zipFile.entries)
			{
				try
				{
					if (ze.isDirectory())
					{
						fDestination = new File();
						fDestination = destinationFolder2ExtractFiles.resolvePath(ze.name);	
						fDestination.createDirectory();					
					}
					else
					{
						//get the ByteArray for the file
						ba = zipFile.getInput(ze);
					
						//get the right destination for the file
						fDestination = destinationFolder2ExtractFiles.resolvePath(ze.name);
				
						//write the file on the destination
						fs = new FileStream();
						fs.open(fDestination, FileMode.WRITE);
						fs.writeBytes(ba);
						fs.close();			
					}	
				}
				catch (ioE:IOError)
				{
					ErrorHandler.onIOError("Zip", fDestination.nativePath);
				}
				catch (se:SecurityError)
				{
					ErrorHandler.onSecurityError("Zip", fDestination.nativePath);
				}
				catch (e:Error)
				{
					//zip errors
					MessageWindow.messageInvalidZipFile();
				}
			}
		}
		
		public static function unzipFile(zipFile:File, destinationFolder2ExtractFiles:File):void
		{
			var fs:FileStream;
			var baZipFile:ByteArray;
			
			try
			{
				fs = new FileStream();
				baZipFile = new ByteArray();
				
				fs.open(zipFile, FileMode.READ);
				fs.readBytes(baZipFile);
				fs.close();
			}
			catch (iE:IOError)
			{
				ErrorHandler.onIOError("Zip", zipFile.nativePath);
			}
			catch (sE:SecurityError)
			{
				ErrorHandler.onSecurityError("Zip", zipFile.nativePath);
			}
			
			unzip(baZipFile, destinationFolder2ExtractFiles);			
		}
		
		public static function unzipToFileNameFolder(zipFile:File, destinationFolder2ExtractFiles:File):String
		{
			var fileNameWithoutExtension:String;
			var indexFileExtensionDot:uint;
			var folderWithFileName:File;
			
			//get the index of the last dot, that indicates the file extension
			indexFileExtensionDot = zipFile.name.lastIndexOf(".");
			fileNameWithoutExtension = zipFile.name.slice(0, indexFileExtensionDot);			
					
			//create the directory with the fileNameWithoutExtension
			folderWithFileName = destinationFolder2ExtractFiles.resolvePath(fileNameWithoutExtension);
			try
			{
				folderWithFileName.createDirectory();
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("Zip", folderWithFileName.nativePath);
			}
			catch (sE:SecurityError)
			{
				ErrorHandler.onSecurityError("Zip", folderWithFileName.nativePath);
			}			
			
			unzipFile(zipFile, folderWithFileName);
			
			return fileNameWithoutExtension;
		}
	}
}
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
	import flaras.errorHandler.*;
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
			
			zipOut = new ZipOutput();
			
			for each(var f:File in folders)
			{
				try
				{
					recZipFolder(zipOut, f, f.name+"/");
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
			
			zipOut.finish();
			
			return zipOut.byteArray;
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
				catch (ioE:IOErrorEvent)
				{
					ErrorHandler.onIOErrorAsynchronous(ioE);
				}
				catch (se:SecurityErrorEvent)
				{
					ErrorHandler.onSecurityErrorAsynchronous(se);
				}							
			}
		}	
	}
}
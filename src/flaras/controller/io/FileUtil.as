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
	import flash.filesystem.*;
	
	public class FileUtil
	{
		private static var obj3DExtensions:Array = ["dae", "3ds"];
		
		public static function recursiveSearch3DFile(folder:File):File
		{
			var directoryListing:Array;
			var ret:File;
			
			directoryListing = folder.getDirectoryListing();
			for each (var entry:File in directoryListing)
			{
				if (entry.isDirectory)
				{
					ret = recursiveSearch3DFile(entry);
					if (ret != null)
					{
						return ret;
					}
				}
				else
				{
					if (isObj3DFile(entry))
					{
						return entry;
					}
				}
			}
			return null;
		}
		
		private static function isObj3DFile(f:File):Boolean
		{
			for each (var ext:String in obj3DExtensions)
			{
				if (f.extension != null)
				{
					if (f.extension.toLowerCase() == ext)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		public static function getFileNameWithoutExtension(f:File):String
		{
			var indexFileExtensionDot:uint;
			
			indexFileExtensionDot = f.name.lastIndexOf(".");
			return f.name.slice(0, indexFileExtensionDot);
		}
		
		//check if the filename contains only letters A-Z/a-z, digits 0-9 and -/_
		public static function hasValidFileName(fileName:String):Boolean
		{
			var regExpValidFileName:RegExp = /[0-9a-zA-Z-_ ]+[.][0-9a-zA-Z]+/
			var match:String = regExpValidFileName.exec(fileName);
			
			// if match is null... then it is an invalid filename
			// else, it's a valid filename if the string matched has the same lenght of the filename
			return !match ? false : (match.length == fileName.length);
		}
	}
}
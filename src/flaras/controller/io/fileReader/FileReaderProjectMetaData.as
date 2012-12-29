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

package flaras.controller.io.fileReader 
{
	import flaras.controller.*;
	import flaras.model.util.*;
	import flash.errors.*;
	import flash.filesystem.*;
	import flash.utils.*;
	
	public class FileReaderProjectMetaData 
	{
		public static function readData(filePath:String):ModelProjectVersion
		{
			var fs:FileStream;
			var f:File;
			var xml:XML;
			var mpv:ModelProjectVersion;
			var ba:ByteArray;
			
			mpv = null;
			try 
			{
				f = new File(filePath);
				if (f.exists)
				{
					fs = new FileStream();
					fs.open(f, FileMode.READ);
					
					ba = new ByteArray();
					fs.readBytes(ba);
					xml = XML(ba);
					fs.close();
					
					mpv = new ModelProjectVersion(xml.version.release, xml.version.subRelease, xml.version.bugFix);
				}				
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOError("FileReaderProjectMetaData", f.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityError("FileReaderProjectMetaData", f.nativePath);
			}
			
			return mpv;		
		}	
	}
}
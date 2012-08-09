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

package flaras.controller.io.fileSaver 
{
	import flaras.*;
	import flaras.controller.*;
	import flaras.controller.constants.XMLFilesConstants;
	import flaras.model.*;
	import flaras.model.marker.*;
	import flaras.model.point.*;
	import flaras.model.scene.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class FileSaver
	{
		private static const defaultXMLHeader:String = "<?xml version = \"1.0\" encoding = \"utf-8\"?>\n";
		
		public static function saveListOfPoints(pListOfPoints:Vector.<Point>, pCurrentProjectTempFolder:File):void
		{
			var ba:ByteArray;
			ba = new ByteArray();
			
			ba.writeUTFBytes(defaultXMLHeader + XMLGenerator.generateXMLPoints(pListOfPoints));
			save(pCurrentProjectTempFolder, XMLFilesConstants.LIST_OF_POINTS_PATH, ba);
		}
		
		public static function saveListOfObjects(pListOfScenes:Vector.<FlarasScene>, pCurrentProjectTempFolder:File, pFilePathListOfObjects:String):void
		{
			var ba:ByteArray;
			ba = new ByteArray();
			
			ba.writeUTFBytes(defaultXMLHeader + XMLGenerator.generateXMLObjects(pListOfScenes));
			save(pCurrentProjectTempFolder, pFilePathListOfObjects, ba);
		}
		
		public static function saveInteractionSphereProperties(tmpFolder:File, modelInteractionMarker:ModelInteractionMarker):void
		{
			var ba:ByteArray;
			
			ba = new ByteArray();
			ba.writeUTFBytes(defaultXMLHeader + XMLGenerator.generateXMLInteractionSphere(modelInteractionMarker));
			save(tmpFolder, XMLFilesConstants.INTERACTION_SPHERE_PATH, ba);
		}
		
		public static function saveRefMarkerProperties(tmpFolder:File, modelRefMarker:ModelRefMarker):void
		{
			var ba:ByteArray;
			
			ba = new ByteArray();
			ba.writeUTFBytes(defaultXMLHeader + XMLGenerator.generateXMLRefMarker(modelRefMarker));
			save(tmpFolder, XMLFilesConstants.REF_MARKER_PROPERTIES_PATH, ba);
		}
		
		private static function save(pCurrentProjectTempFolder:File, pFileName:String, pObjByteArray:ByteArray):void
		{
			var outStream:FileStream;
			var outFile:File;
			
			outFile = pCurrentProjectTempFolder.resolvePath(pFileName);
			
			//writing the file on the disk
			
			try
			{
				outStream= new FileStream();
				outStream.open(outFile, FileMode.WRITE);
				outStream.writeBytes(pObjByteArray); 
				outStream.close();	
			}
			catch (ioE:IOError)
			{
				ErrorHandler.onIOErrorSynchronous(ioE, outFile.nativePath);
			}
			catch (se:SecurityError)
			{
				ErrorHandler.onSecurityErrorSynchronous(se, outFile.nativePath);
			}
		}
	}

}
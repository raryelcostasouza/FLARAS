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
	import flaras.controller.io.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	
	public class FileReaderListOfPoints extends FileReader
	{
		public function FileReaderListOfPoints(pFilePath:String, pObjCtrPoint:CtrPoint)
		{
			super(pObjCtrPoint);
			readFile(pFilePath);
		}
		
		private function readFile(pFilePath:String):void
		{
			var fileLoader:URLLoader = new URLLoader(new URLRequest(pFilePath));
			
			fileLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);
			fileLoader.addEventListener(Event.COMPLETE, onComplete);
            fileLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous); 
            fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous); 
		}
		
		private function onComplete(e:Event):void
		{			
			e.target.removeEventListener(Event.COMPLETE, onComplete);
			aXMLFile = XML(e.target.data);
			
			for each (var point:XML in aXMLFile.point) 
			{
				aObjCtrPoint.addPointFromXML(new Number3D(point.position.x, point.position.y, point.position.z));
			}
			
			aObjCtrPoint.finishedReadingListOfPoints();
		}	
	}
	
}
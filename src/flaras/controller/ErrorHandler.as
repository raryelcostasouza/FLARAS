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
	import flaras.userInterface.graphicUserInterfaceComponents.*;
	import flaras.view.gui.*;
	import flash.errors.*;
	import flash.events.*;
	
	public class ErrorHandler 
	{
		private static const DEFAULT_IO_ERROR_MESSAGE:String = "It has happened an IOError.\nMore details:\n";
		private static const DEFAULT_SECURITY_ERROR_MESSAGE:String = "It has happened a SecurityError.\nMore details:\n";
		
		public static function onIOErrorAsynchronous(e:IOErrorEvent):void
		{	
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorAsynchronous);
			notifyError(DEFAULT_IO_ERROR_MESSAGE + e.text);
		}
		
		public static function onIOErrorSynchronous(ioE:IOError, filePath:String):void
		{
			notifyError(DEFAULT_IO_ERROR_MESSAGE + "fileName: "+ filePath + "\n" + ioE.message);
		}
		
		public static function onSecurityErrorAsynchronous(e:SecurityErrorEvent):void
		{
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorAsynchronous);
			notifyError(DEFAULT_SECURITY_ERROR_MESSAGE + e.text);
		}
		
		public static function onSecurityErrorSynchronous(se:SecurityError, filePath:String):void
		{
			notifyError(DEFAULT_SECURITY_ERROR_MESSAGE + "fileName: "+ filePath + "\n" + se.message);
		}
		
		private static function notifyError(errorMessage:String):void
		{
			MessageWindow.errorMessage(errorMessage);
		}
	}
}
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

package flaras.view.gui 
{
	import flaras.controller.constants.GeneralConstants;
	import flash.events.*;
	import flash.net.*;
	import org.aswing.*;
	
	public class MessageWindow 
	{		
		public static function messageSceneAlreadyOnAttractList():void
		{
			JOptionPane.showMessageDialog("Warning!", "The selected scene is alredy on the list\n"+ 
														"of scenes to attract of this point.", 
										null, null, true, new LoadIcon("icons/external/warning.png", 48, 48));
		}
		
		public static function messageSelectScene2Remove():void
		{
			JOptionPane.showMessageDialog("Warning!", "Before clicking the remove button\n" +
														"please select a scene to remove from the list.", 
										null, null, true, new LoadIcon("icons/external/warning.png", 48, 48));
		}
		
		public static function messageIncompatibleProjectVersion(minimumVersionRequired:String):void
		{
			JOptionPane.showMessageDialog("Error!", "Could not open the project!"+
											"\nYou are using FLARAS " + GeneralConstants.MODEL_PROJECT_VERSION.toString() + ", but this project was created by FLARAS " + minimumVersionRequired + "."+
											"\nDownload and install FLARAS " + minimumVersionRequired + " (or later versions) to be able to open this project.", 
											null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
		}
		
		public static function messageWarningField(pValue:String, pFieldName:String):void
		{
			JOptionPane.showMessageDialog("Warning!","Invalid number '" + pValue + "' on field " + pFieldName+ ".\nYour changes will not be applied until this field have a valid value!", null, null, true, new LoadIcon("icons/external/warning.png", 48, 48));
		}
		
		public static function messageSaveSuccess():void
		{
			JOptionPane.showMessageDialog("Project saved", "The project was succesfully saved!", null, null, true, new LoadIcon("icons/external/check.png", 48, 48));
		}
		
		public static function messageInvalidDAEFile():void
		{
			JOptionPane.showMessageDialog("Error!", "There is no valid virtual object file (DAE or 3DS) on the selected file", null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
		}
		
		public static function messageInvalidZipFile():void
		{
			JOptionPane.showMessageDialog("Error!", "Invalid/corrupted kmz/zip file! \nOne possible cause for this problem may be that the kmz/zip file contains filenames with accented/special characters. \nFLARAS just works with non-accented filenames. \nOpen the zip file with your archiver (Winzip, WinRAR, 7-zip,etc) and rename accented files before trying to insert this zip/kmz file on FLARAS again.", null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
		}
		
		public static function messageProjectNotSaved2Publish():void
		{
			JOptionPane.showMessageDialog("Warning!", "You must save your project before trying to publish it!", null, null, true, new LoadIcon("icons/external/warning.png", 48, 48));
		}
		
		//message window called before opening a project or creating a new project
		public static function messageSaveBeforeAction(saveBeforeAction:Function, dontSaveBefore:Function):void
		{
			var msg:String = "Would you like to save your project before?";
			
			messageConfirmation(msg, true, saveBeforeAction, dontSaveBefore);
		}
	
		public static function messageOverwriteConfirmation(confirmAction:Function, cancelAction:Function, fileName:String, folderName:String):void
		{
			var msg:String = "There is already another file named \"" 
							+ fileName + "\" on the folder \"" + folderName +
							"\". \nWould you like to overwrite it?"
			
			messageConfirmation(msg, false, confirmAction, cancelAction);
		}
		
		private static function messageConfirmation(msg:String, showCancelButton:Boolean, yesAction:Function, noAction:Function):void
		{
			var buttons2show:int;
			
			buttons2show = JOptionPane.YES + JOptionPane.NO;
			
			if (showCancelButton)
			{
				buttons2show += JOptionPane.CANCEL;
			}
			
			var jop:JOptionPane = JOptionPane.showMessageDialog("Confirmation", msg, null, null,
			true, new LoadIcon("icons/external/warning.png", 48, 48), buttons2show);
			
			jop.getYesButton().addActionListener(yesAction);
			jop.getNoButton().addActionListener(noAction);			
		}
		
		
		public static function errorMessage(errorMessage:String):void
		{
			JOptionPane.showMessageDialog("Error!", errorMessage, null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
		}		
		
		public static function licenseFlaras():void
		{
			JOptionPane.showMessageDialog("License", 
			"Copyright (C) 2011-2013 Raryel, Hipolito, Claudio\n\n" +
			
			"This program is free software: you can redistribute it and/or modify\n"+
			"it under the terms of the GNU General Public License as published by\n" +
			"the Free Software Foundation, either version 3 of the License, or\n" +
			"(at your option) any later version.\n\n"+

			"This program is distributed in the hope that it will be useful,\n"+
			"but WITHOUT ANY WARRANTY; without even the implied warranty of\n"+
			"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n"+
			"GNU General Public License for more details.\n\n"+

			"You should have received a copy of the GNU General Public License\n"+
			"along with this program.  If not, see <http://www.gnu.org/licenses/>."
			, null, null);
		}
		
		public static function aboutFlaras():void
		{
			var jop:JOptionPane = JOptionPane.showMessageDialog("About FLARAS", 
			"Flash Augmented Reality Authoring System\n\n" +
			"Version 2.4.0 - March, 04 2013\n\n" +
			
			"Copyright (C) 2011-2012 Raryel, Hipolito, Claudio\n\n" +
			"Official Website: http://www.ckirner.com/flaras\n\n" +
			"Developers: \n" +
			"Raryel Costa Souza - raryel.costa@gmail.com\n" +
			"Hipolito Douglas Franca Moreira - hipolitodouglas@gmail.com\n\n" +	
			"Advisor: Claudio Kirner - ckirner@gmail.com\n\n" +		
			
			"Developed at UNIFEI - Federal University of Itajuba - Minas Gerais - Brazil\n" +
			"Research scholarship by FAPEMIG (Fundação de Amparo à Pesquisa no Estado de Minas Gerais) and\n" +
			"CNPq (Conselho Nacional de Desenvolvimento Científico e Tecnológico)\n"
			
			, null, null, true, new LoadIcon("icons/flaras128.png", 128, 128), JOptionPane.OK | JOptionPane.CANCEL);
			
			jop.getOkButton().setText("Open FLARAS Website");
			jop.getCancelButton().setText("Close");
			
			jop.getOkButton().addActionListener(
			function(e:Event):void
			{
				navigateToURL(new URLRequest("http://www.ckirner.com/flaras"));
			});
		}
		
		public static function messageMoveInteractionNotAllowed():void
		{
			JOptionPane.showMessageDialog("Warning!", "Move interaction is not allowed for the scenes of this point!", null, null, true, new LoadIcon("icons/external/warning.png", 48, 48));
		}
	}
}
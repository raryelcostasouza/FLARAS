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
	import flash.events.*;
	import flash.net.*;
	import org.aswing.*;
	
	public class MessageWindow 
	{
		public static const OBJ3D_INVALID_FILENAME:String = "The obj3D file inside this zipped file has an invalid filename!";
		public static const OTHER_TYPE_INVALID_FILENAME:String = "Invalid filename!";	
		
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
			JOptionPane.showMessageDialog("Error!", "Invalid/corrupted zip file! One possible cause for this problem may be that the zip file contains filenames with accented/special characters. \nFLARAS just works with non-accented filenames. \nRename these files before trying to insert this zip file on FLARAS again.", null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
		}
		
		public static function messageInvalidFileName(type:String):void
		{
			JOptionPane.showMessageDialog("Error!", type + "\nOnly the following characters are allowed for filenames: \n\na-z \nA-Z \n0-9 \n-(hyphen) \n_(underscore) \n\nFilenames with spaces and special characters are NOT allowed.", null, null, true, new LoadIcon("icons/external/error.png", 48, 48));
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
		
		public static function keyboardCommands():void
		{
			JOptionPane.showMessageDialog("FLARAS Keys", 
			"Keys related with points:\n"+
			"Ctrl + A: Enable all points\n" +
			"Ctrl + Q: Disable all points\n" +
			"F1: Toggle aux points (available only for enable points). It will appear a blue sphere on the point position.\n\n" +
			"\nCtrl + 1: apply an inspection interaction to the point 1 and select it for keyboard interaction.\n" +
			"Ctrl + 2: apply an inspection interaction to the point 2...\n"+
			"...\n" +
			"Ctrl + 0: ... to the point 10\n"+
			"Page Down: apply control forward interaction to the selected point.\n" +
			"Page Up: apply control backward interaction to the selected point.\n" +
			"End: unselect the previously selected point (Page Down and Page Up will have no more effect).\n\n"+
			
			"Keys related with the interaction marker:\n"+
			"Ctrl + M: Toggle marker type (inspector/control)\n" +
			"Ctrl + C: Toggle control marker type (backward/forward) (only available if the marker type is control)\n\n" +
			
			"Keys related with the interaction sphere:\n"+
			"F4: Decrease size\n" +
			"F5: Increase size\n" +
			"F6: Decrease distance\n" +
			"F7: Increase distance\n" +
			"F8: Reset properties\n\n" +
			
			"Others keys:\n" +
			"F3: Toggle mirror screen\n" +
			"Ctrl + P: Toggle reference marker persistence\n\n", null, null);
		}
		
		public static function mouseCommands():void
		{
			JOptionPane.showMessageDialog("FLARAS Mouse Interaction Commands", 
			"Left click on a point: enable the point\n" +
			"Left click on a scene (video, texture, obj3d): control forward interaction (go to the next scene)\n" +
			"Right click on a scene: control backward interaction (go to the previous scene)\n" +
			"Ctrl + click on a scene: disable the point\n", null, null);
		}
		
		
		public static function licenseFlaras():void
		{
			JOptionPane.showMessageDialog("License", 
			"Copyright (C) 2011-2012 Raryel, Hipolito, Claudio\n\n" +
			
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
			"Version 1.0-r1115 - July, 19 2012\n\n" +
			
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
	}
}
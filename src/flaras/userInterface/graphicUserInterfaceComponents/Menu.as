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

package flaras.userInterface.graphicUserInterfaceComponents
{
	import flaras.controller.*;
	import flaras.userInterface.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;

	public class Menu extends JMenuBar
	{
		private var aControl:CtrInteractionUI;
		private var aCtrGUI:CtrGUI;
		
		private var menuArchive:JMenu = new JMenu("File");
		private var newFlaras:JMenuItem = new JMenuItem("&New");
		private var openFlaras:JMenuItem = new JMenuItem("&Open");
		private var publish:JMenuItem = new JMenuItem("&Publish");
		private var saveFlaras:JMenuItem = new JMenuItem("&Save");
		private var saveAsFlaras:JMenuItem = new JMenuItem("Save &as...");
		private var exitFlaras:JMenuItem = new JMenuItem("E&xit");
		
		private var menuAbout:JMenu =  new JMenu("About");
		private var jmiKeys:JMenuItem = new JMenuItem("&Keyboard commands");
		private var jmiAboutFlaras:JMenuItem = new JMenuItem("&About FLARAS");
		private var jmiLicense:JMenuItem = new JMenuItem("&License");
		
		public function Menu(pControl:CtrInteractionUI, pCtrGUI:CtrGUI):void
		{
			this.aControl = pControl;
			this.addMenu(menuArchive);
			
			aCtrGUI = pCtrGUI;
			menuArchive.append(newFlaras);
			
			newFlaras.addActionListener(newFunction);
			
			menuArchive.append(openFlaras);
			
			openFlaras.addActionListener(openFunction);
			
			menuArchive.append(new JSeparator());
			menuArchive.append(saveFlaras);
				
			saveFlaras.addActionListener(saveFunction);
			
			menuArchive.append(saveAsFlaras);
			saveAsFlaras.addActionListener(saveAsFunction);
			
			menuArchive.append(publish);
			
			publish.addActionListener(publishOfflineFunction);
			
			menuArchive.append(new JSeparator());
			menuArchive.append(exitFlaras);
			exitFlaras.addActionListener(exitFunction);
			
			this.addMenu(menuAbout);
			menuAbout.append(jmiKeys);
			jmiKeys.addActionListener(flarasKeys);
			menuAbout.append(jmiLicense);
			jmiLicense.addActionListener(licenseFlarasFunction);
			menuAbout.append(jmiAboutFlaras);
			jmiAboutFlaras.addActionListener(aboutFlarasFunction);
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
			setBorder(new LineBorder());
		}
		
		private function newFunction(e:Event):void 
		{
			aControl.getObjCtrUserProject().createNewProject();
		}
		
		private function openFunction(e:Event):void 
		{
			aControl.getObjCtrUserProject().openProject();
		}
		
		private function publishOfflineFunction(e:Event):void
		{
			aControl.getObjCtrUserProject().publishProject();
		}
		
		private function saveFunction(e:Event):void 
		{
			aControl.getObjCtrUserProject().saveProject();
		}
		
		private function saveAsFunction(e:Event):void 
		{
			aControl.getObjCtrUserProject().saveProjectAs();
		}
		
		private function exitFunction(e:Event):void 
		{
			aControl.getObjCtrUserProject().closingFlaras();
		}
		
		private function flarasKeys(e:Event):void
		{
			MessageWindow.keyboardCommands();
		}
		
		private function aboutFlarasFunction(e:Event):void
		{
			MessageWindow.aboutFlaras();
		}
		
		private function licenseFlarasFunction(e:Event):void
		{
			MessageWindow.licenseFlaras();
		}
	}
}
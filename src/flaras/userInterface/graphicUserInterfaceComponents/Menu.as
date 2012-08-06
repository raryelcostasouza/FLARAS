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
		private var _ctrMain:CtrMain;
		private var aCtrGUI:CtrGUI;
		
		private var menuArchive:JMenu = new JMenu("File");
		private var newFlaras:JMenuItem = new JMenuItem("&New");
		private var openFlaras:JMenuItem = new JMenuItem("&Open");
		private var publish:JMenuItem = new JMenuItem("&Publish");
		private var saveFlaras:JMenuItem = new JMenuItem("&Save");
		private var saveAsFlaras:JMenuItem = new JMenuItem("Save &as...");
		private var exitFlaras:JMenuItem = new JMenuItem("E&xit");
		
		private var menuView:JMenu = new JMenu("View");
		private var refMarkerPersitence:JCheckBoxMenuItem = new JCheckBoxMenuItem("Ref. marker persistence");
		private var mirrorScreen:JCheckBoxMenuItem = new JCheckBoxMenuItem("Camera mirror");
		private var stopCameraCapture:JCheckBoxMenuItem = new JCheckBoxMenuItem("Stop camera");
		private var chooseCaptureCamera:JMenuItem = new JMenuItem("Choose camera");
		
		private var menuAbout:JMenu =  new JMenu("About");
		private var jmiKeys:JMenuItem = new JMenuItem("&Keyboard commands");
		private var jmiAboutFlaras:JMenuItem = new JMenuItem("&About FLARAS");
		private var jmiLicense:JMenuItem = new JMenuItem("&License");
		
		public function Menu(ctrMain:CtrMain, pCtrGUI:CtrGUI):void
		{
			_ctrMain = ctrMain;
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
			
			this.addMenu(menuView);
			menuView.append(refMarkerPersitence);
			refMarkerPersitence.addActionListener(actionToggleRefMarkerPersistence);
			menuView.append(mirrorScreen);
			mirrorScreen.addActionListener(actionMirrorScreen);
			menuView.append(stopCameraCapture);
			stopCameraCapture.addActionListener(actionStopCameraCapture);
			menuView.append(new JSeparator());
			menuView.append(chooseCaptureCamera);
			chooseCaptureCamera.addActionListener(actionChooseCaptureCamera);
			
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
			_ctrMain.ctrUserProject.createNewProject();
		}
		
		private function openFunction(e:Event):void 
		{
			_ctrMain.ctrUserProject.openProject();
		}
		
		private function publishOfflineFunction(e:Event):void
		{
			_ctrMain.ctrUserProject.publishProject();
		}
		
		private function saveFunction(e:Event):void 
		{
			_ctrMain.ctrUserProject.saveProject();
		}
		
		private function saveAsFunction(e:Event):void 
		{
			_ctrMain.ctrUserProject.saveProjectAs();
		}
		
		private function exitFunction(e:Event):void 
		{
			_ctrMain.ctrUserProject.closingFlaras();
		}
		
		private function actionToggleRefMarkerPersistence(e:Event):void
		{
			_ctrMain.ctrMarker.toggleRefMarkerPersistence();
		}
		
		public function setStatusJCBRefMarkPersist(enabled:Boolean):void
		{
			refMarkerPersitence.setSelected(enabled);
		}
		
		private function actionMirrorScreen(e:Event):void
		{
			_ctrMain.ctrMirror.toggleMirror(false);
		}
		
		private function actionStopCameraCapture(e:Event):void
		{
			_ctrMain.ctrCamera.setCameraStatus(stopCameraCapture.isSelected());
		}
		
		private function actionChooseCaptureCamera(e:Event):void
		{
			_ctrMain.ctrCamera.selectCameraToCapture();
		}
		
		public function setStatusJCBMirrorScreen(enabled:Boolean):void
		{
			mirrorScreen.setSelected(enabled);
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
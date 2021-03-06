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
	import flaras.controller.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;

	public class Menu extends JMenuBar
	{
		private var _ctrMain:CtrMain;
		
		private var menuArchive:JMenu = new JMenu("File");
		private var newFlaras:JMenuItem = new JMenuItem("New", new LoadIcon("icons/external/new.png"));
		private var openFlaras:JMenuItem = new JMenuItem("Open", new LoadIcon("icons/external/open.png"));
		private var publish:JMenuItem = new JMenuItem("Publish", new LoadIcon("icons/external/publish.png"));
		private var saveFlaras:JMenuItem = new JMenuItem("Save", new LoadIcon("icons/external/save.png"));
		private var saveAsFlaras:JMenuItem = new JMenuItem("Save as...");
		private var exitFlaras:JMenuItem = new JMenuItem("Exit", new LoadIcon("icons/external/exit.png"));
		
		private var menuView:JMenu = new JMenu("View");
		private var stopCameraCapture:JCheckBoxMenuItem = new JCheckBoxMenuItem("Stop camera");
		private var chooseCaptureCamera:JMenuItem = new JMenuItem("Choose camera");
	
		private var menuAbout:JMenu =  new JMenu("About");
		private var jmiAboutFlaras:JMenuItem = new JMenuItem("About FLARAS", new LoadIcon("icons/flaras16.png"));
		private var jmiLicense:JMenuItem = new JMenuItem("License");
		
		public function Menu(ctrMain:CtrMain):void
		{
			_ctrMain = ctrMain;
			this.addMenu(menuArchive);
			
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
			menuView.append(new JSeparator());
			menuView.append(stopCameraCapture);
			stopCameraCapture.addActionListener(actionStopCameraCapture);
			menuView.append(new JSeparator());
			menuView.append(chooseCaptureCamera);
			chooseCaptureCamera.addActionListener(actionChooseCaptureCamera);
			
			this.addMenu(menuAbout);
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
		
		private function actionStopCameraCapture(e:Event):void
		{
			_ctrMain.ctrCamera.setCameraStatus(stopCameraCapture.isSelected());
		}
		
		private function actionChooseCaptureCamera(e:Event):void
		{
			_ctrMain.ctrCamera.selectCameraToCapture();
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
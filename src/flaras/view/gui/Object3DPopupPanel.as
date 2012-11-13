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
	import org.aswing.*;
	
	public class Object3DPopupPanel extends JPopup
	{
		private var objFile:JTextField;
		private var btnFileLoad:JButton;
		
		public function Object3DPopupPanel(pCtrGUI:CtrGUI)
		{
			setLayout(new FlowLayout());
			append(new JLabel("URL"));
			append(objFile = new JTextField("", 14));
			objFile.setEditable(false);
			append(btnFileLoad = new JButton("..."));
			btnFileLoad.addActionListener(pCtrGUI.fileLoad);
		}
		
		public function getObjFile():JTextField
		{
			return objFile;
		}
		
		public function getFilePath():String
		{
			return objFile.getText();
		}
		
		public function getBtnObject3dLoad():JButton
		{
			return btnFileLoad;
		}
	}
}
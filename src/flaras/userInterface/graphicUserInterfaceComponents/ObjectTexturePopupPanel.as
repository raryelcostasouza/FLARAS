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
	import flaras.userInterface.CtrGUI;
	import flash.events.KeyboardEvent;
	import org.aswing.*;
	import org.aswing.geom.IntDimension;
	
	public class ObjectTexturePopupPanel extends JPopup
	{
		private var objTexture:JTextField;
		private var btnTextureLoad:JButton;
		private var objTextureWidth:JTextField;
		private var objTextureHeight:JTextField;
		
		public function ObjectTexturePopupPanel(pCtrGUI:CtrGUI)
		{
			setLayout(new FlowLayout());
			append(new JLabel("URL"));
			append(objTexture = new JTextField("", 14));
			objTexture.setEditable(false);
			append(btnTextureLoad = new JButton("..."));
			btnTextureLoad.addActionListener(pCtrGUI.textureLoad);
			append(new JLabel("Dimensions"));
			append(new JLabel("                                   "));
			append(new JLabel("Width"));
			append(objTextureWidth = new JTextField("", 5));
			objTextureWidth.addActionListener(pCtrGUI.updateSceneTextureSize);
			objTextureWidth.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel("Height"));
			append(objTextureHeight = new JTextField("", 5));
			objTextureHeight.addActionListener(pCtrGUI.updateSceneTextureSize);
			objTextureHeight.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			setPreferredSize(new IntDimension(200, 200));
		}
		
		public function getObjTexture():JTextField
		{
			return objTexture;
		}
		
		public function getObjTextureHeight():JTextField
		{
			return objTextureHeight;
		}
		
		public function getObjTextureWidth():JTextField
		{
			return objTextureWidth;
		}
		
		public function getBtnTextureLoad():JButton
		{
			return btnTextureLoad;
		}
	}

}
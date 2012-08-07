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
	import flaras.userInterface.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.geom.*;
	
	public class ObjectVideoPopupPanel extends JPopup
	{
		private var objVideo:JTextField;
		private var btnVideoLoad:JButton;
		private var objVideoWidth:JTextField;
		private var objVideoHeight:JTextField;
		private var objVideoRpt:JCheckBox;
		
		public function ObjectVideoPopupPanel(pCtrGUI:CtrGUI)
		{
			setLayout(new FlowLayout());
			append(new JLabel("URL"));
			append(objVideo = new JTextField("", 14));
			objVideo.setEditable(false);
			append(btnVideoLoad = new JButton("..."));
			btnVideoLoad.addActionListener(pCtrGUI.videoLoad);
			append(new JLabel("Dimensions"));
			append(new JLabel("                                   "));
			append(new JLabel("Width"));
			append(objVideoWidth = new JTextField("", 5));
			objVideoWidth.addActionListener(pCtrGUI.updateSceneVideoSize);
			objVideoWidth.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel("Height"));
			append(objVideoHeight = new JTextField("", 5));
			objVideoHeight.addActionListener(pCtrGUI.updateSceneVideoSize);
			objVideoHeight.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(objVideoRpt = new JCheckBox("Repeat"));
			objVideoRpt.addActionListener(pCtrGUI.setRepeatVideo);
			setPreferredSize(new IntDimension(200, 200));
		}
		
		public function getObjVideo():JTextField
		{
			return objVideo;
		}
		
		public function getObjVideoWidth():JTextField
		{
			return objVideoWidth;
		}
		
		public function getObjVideoHeight():JTextField
		{
			return objVideoHeight;
		}
		
		public function getObjVideoRpt():JCheckBox
		{
			return objVideoRpt;
		}
		
		public function getBtnVideoLoad():JButton
		{
			return btnVideoLoad;
		}
	
	}
}
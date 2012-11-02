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
	
	public class ViewGUIInteraction 
	{
		private var _ctrInteraction:CtrInteraction;
		private var _viewWindowInteractionSphere:ViewWindowInteractionSphere;
		private var _jtbControlBackward:JToggleButton;
		private var _jtbControlForward:JToggleButton;
		private var _jtbInspection:JToggleButton;
		private var _jtbMove:JToggleButton
		
		public function ViewGUIInteraction(ctrInteraction:CtrInteraction) 
		{
			var jw:JWindow;
			var mainPanel:JPanel;
			
			this._ctrInteraction = ctrInteraction;
			this._viewWindowInteractionSphere = new ViewWindowInteractionSphere(_ctrInteraction);
			
			jw = new JWindow();
			jw.setContentPane(buildMainPanel());
			jw.setSizeWH(640, 60);
			jw.setLocationXY(0, 480);
			jw.show();
		}
		
		private function buildMainPanel():JPanel
		{
			var mainPanel:JPanel = new JPanel();
			var jtbar:JToolBar = new JToolBar();
			
			buildInteractionPanel(jtbar);
			buildViewPanel(jtbar);
			buildAllPointsPanel(jtbar);
			
			mainPanel.append(jtbar);
			
			return mainPanel
		}
		
		private function buildInteractionPanel(pJToolBar:JToolBar):void
		{			
			_jtbControlBackward = new JToggleButton(null, new LoadIcon("icons/external/backward.png"));
			_jtbControlForward = new JToggleButton(null, new LoadIcon("icons/external/forward.png"));
			_jtbInspection = new JToggleButton(null, new LoadIcon("icons/external/inspection.png"));
			_jtbMove = new JToggleButton(null, new LoadIcon("icons/external/move.png"));
			
			_jtbInspection.setSelected(true);
			
			_jtbControlBackward.setToolTipText("Backward");
			_jtbControlForward.setToolTipText("Forward");
			_jtbInspection.setToolTipText("Inspection");
			_jtbMove.setToolTipText("Move");
			
			_jtbControlBackward.addActionListener(function(e:Event):void
			{
				if (_jtbControlBackward.isSelected())
				{
					_jtbControlForward.setSelected(false);
					_jtbInspection.setSelected(false);
					_jtbMove.setSelected(false);
					
					_ctrInteraction.getCtrMain().ctrMarker.setMarkerType2ControlBackward();
				}
			});
			_jtbControlForward.addActionListener(function(e:Event):void
			{
				if (_jtbControlForward.isSelected())
				{
					_jtbControlBackward.setSelected(false);
					_jtbInspection.setSelected(false);
					_jtbMove.setSelected(false);
					
					_ctrInteraction.getCtrMain().ctrMarker.setMarkerType2ControlForward();
				}
			});
			_jtbInspection.addActionListener(function(e:Event):void
			{
				if (_jtbInspection.isSelected())
				{
					_jtbControlBackward.setSelected(false);
					_jtbControlForward.setSelected(false);
					_jtbMove.setSelected(false);
					
					_ctrInteraction.getCtrMain().ctrMarker.setMarkerType2Inspection();
				}
			});
			_jtbMove.addActionListener(function(e:Event):void
			{
				if (_jtbMove.isSelected())
				{
					_jtbControlBackward.setSelected(false);
					_jtbControlForward.setSelected(false);
					_jtbInspection.setSelected(false);
				}
			});
			
			pJToolBar.append(_jtbInspection);
			pJToolBar.append(_jtbControlBackward);
			pJToolBar.append(_jtbControlForward);
			pJToolBar.append(_jtbMove);
		}
		
		private function buildViewPanel(pJToolBar:JToolBar):void
		{			
			var jtbMirrorScreen:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/camera-mirror.png"));			
			var jtbMarkerPersistence:JToggleButton = new JToggleButton(null, new LoadIcon("icons/markerIcon.png"));			
			var jbInteractionMarker:JButton = new JButton(null, new LoadIcon("icons/interactionMarkerIcon.png"));
			
			jtbMirrorScreen.setToolTipText("Mirror camera");
			jtbMarkerPersistence.setToolTipText("Marker persistence");
			jbInteractionMarker.setToolTipText("Interaction marker properties");
			
			jtbMirrorScreen.addActionListener(function(e:Event):void
			{
				_ctrInteraction.getCtrMain().ctrMirror.toggleMirror(true);
			});
			jtbMarkerPersistence.addActionListener(function(e:Event):void
			{
				_ctrInteraction.getCtrMain().ctrMarker.toggleRefMarkerPersistence();
			});
			jbInteractionMarker.addActionListener(function(e:Event):void
			{
				_viewWindowInteractionSphere.setVisible(true);
			});
			
			
			pJToolBar.append(new JSeparator(JSeparator.VERTICAL));
			pJToolBar.append(jtbMirrorScreen);
			pJToolBar.append(jtbMarkerPersistence);
			pJToolBar.append(jbInteractionMarker);
		}
		
		private function buildAllPointsPanel(pJToolBar:JToolBar):void
		{			
			var jbEnableAll:JButton = new JButton(null, new LoadIcon("icons/external/enable.png"));
			var jbDisableAll:JButton = new JButton(null, new LoadIcon("icons/external/disable.png"));
			
			jbEnableAll.setToolTipText("Enable all points");
			jbDisableAll.setToolTipText("Disable all points");
			
			jbEnableAll.addActionListener(function(e:Event):void
			{
				_ctrInteraction.getCtrMain().ctrPoint.enableAllPoints();
			});
			jbDisableAll.addActionListener(function(e:Event):void
			{
				_ctrInteraction.getCtrMain().ctrPoint.disableAllPoints(true);
			});
			
			pJToolBar.append(new JSeparator(JSeparator.VERTICAL));
			pJToolBar.append(jbEnableAll);
			pJToolBar.append(jbDisableAll);
		}
		
		public function getViewWindowInteractionSphere():ViewWindowInteractionSphere 
		{ 
			return _viewWindowInteractionSphere; 
		}
		
		public function isInspectionSelected():Boolean
		{
			return _jtbInspection.isSelected();
		}
		
		public function isControlBackwardSelected():Boolean
		{
			return _jtbControlBackward.isSelected();
		}
		
		public function isControlForwardSelected():Boolean
		{
			return _jtbControlForward.isSelected();
		}
		
		public function isMoveSelected():Boolean
		{
			return _jtbMove.isSelected();
		}
	}
}
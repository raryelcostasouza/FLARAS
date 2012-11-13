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
	import FTK.*;
	import org.libspark.flartoolkit.support.pv3d.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	
	public class MarkerNodeManager
	{
		private static var markerNodeList:Vector.<FLARBaseNode>;
		private static var markerList:Vector.<MarkerData>;
		
		public static function addObj2MarkerNode(pObj3D:DisplayObject3D,markerCode:uint, pStr:String):void
		{
			markerNodeList[markerCode].addChild(pObj3D, pStr);
		}
		
		public static function removeObjFromMarkerNodeByName(pStrObj:String, markerCode:uint):void
		{
			markerNodeList[markerCode].removeChildByName(pStrObj);
		}
		
		public static function removeObjFromMarkerNode(pObj3D:DisplayObject3D, markerCode:uint):void
		{
			markerNodeList[markerCode].removeChild(pObj3D);
		}
		
		public static function isMarkerDetected(markerCode:uint):Boolean
		{
			return markerList[markerCode].isDetect;
		}
		
		public static function getPosition(markerCode:uint):Number3D
		{
			return markerNodeList[markerCode].position; 
		}
		
		public static function getTransfMatrix(markerCode:uint):Matrix3D
		{
			return markerNodeList[markerCode].transform;
		}
		
		public static function getWorldTransfMatrix(markerCode:uint):Matrix3D
		{
			return markerNodeList[markerCode].world;
		}
		
		public static function init(pMarkerNodeList:Vector.<FLARBaseNode>, pMarkerList:Vector.<MarkerData>):void
		{
			markerNodeList = pMarkerNodeList;
			markerList = pMarkerList;
		}
	}	
}
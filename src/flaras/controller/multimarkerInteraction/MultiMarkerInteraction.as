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

package flaras.controller.multimarkerInteraction 
{
	import flaras.controller.*;
	import flaras.controller.util.*;
	import flaras.model.marker.*;
	import flaras.view.point.*;
	import flash.display.*;
	import org.papervision3d.core.math.*;
	
	public class MultiMarkerInteraction
	{				
		//convert the coordinates of a marker 1 relative to the camera to 
		//coordinates relative to another marker of reference (marker 2)
		protected function convertCoordMarker1CameraToCoordMarker2(pCodeMarker1:uint, pCodeMarkerRef:uint):Number3D
		{
			//multiplying the inverse of the World Matrix of the reference marker (marker 2) by the World Matrix of the marker 1
			var conversionMatrix:Matrix3D = Matrix3D.multiply(Matrix3D.inverse(MarkerNodeManager.getWorldTransfMatrix(pCodeMarkerRef)),MarkerNodeManager.getWorldTransfMatrix(pCodeMarker1));
			
			//converted coordinates of the marker 1 relative to the reference marker (marker 2)
			var convertedCoordMarker1:Number3D = new Number3D(conversionMatrix.n14, conversionMatrix.n24, conversionMatrix.n34);
			
			return convertedCoordMarker1;
		}
		
		//convert the coordinates of a point attached to marker 1 to coordinates relative to a reference marker (marker 2)
		protected function convertCoordPointToCoordMarker2(pCodeMarker1:uint, pCodeMarkerRef:uint, pWorldMatrixInteractionPoint:Matrix3D):Number3D
		{
			//multiplying the inverse of the World Matrix of the reference marker (marker 2) by the World Matrix of the interaction point
			var conversionMatrix:Matrix3D = Matrix3D.multiply(Matrix3D.inverse(MarkerNodeManager.getWorldTransfMatrix(pCodeMarkerRef)), pWorldMatrixInteractionPoint);
			
			//converted coordinates of the point attached to marker 1 relative to the reference marker (marker2)
			var convertedCoordPointMarker1:Number3D = new Number3D(conversionMatrix.n14, conversionMatrix.n24, conversionMatrix.n34);
			
			return convertedCoordPointMarker1;
		}
	
		protected function happenedSphereCollision(pTestPoint:Number3D, pObjInteractionSphere:InteractionSphere):Boolean
		{
			var dist:Number = Point3D.distance(pTestPoint, pObjInteractionSphere.getCenter());
		
			// if the distance between the center of the spheres (the sphere of the point and the lock sphere)
			// is smaller than the sum of the two radius
			if (dist <= pObjInteractionSphere.getRadius() + ViewPoint.RADIUS_SPHERE_OF_POINT)
			{
				return true;
			}
			else
			{
				return false;
			}			
		}
	}
}
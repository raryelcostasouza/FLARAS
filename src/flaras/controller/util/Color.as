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

package flaras.controller.util
{
	import org.papervision3d.lights.*;
	import org.papervision3d.materials.shadematerials.*;
	
	public class Color
	{
		public static const light:PointLight3D = setLight(0,0,1000);
		
		public static const green:FlatShadeMaterial = new FlatShadeMaterial(light, 0x00ff00, 0x00ff00);
		public static const red:FlatShadeMaterial = new FlatShadeMaterial(light,0xff2400,0xffa799); 
		public static const gray:FlatShadeMaterial = new FlatShadeMaterial(light,0x838b8b,0xc1cdcd); 
		public static const blue:FlatShadeMaterial = new FlatShadeMaterial(light,0x0000ee,0x3333ff);
		public static const yellow:FlatShadeMaterial = new FlatShadeMaterial(light, 0xffe600, 0xfbec5d);
		public static const pink:FlatShadeMaterial = new FlatShadeMaterial(light, 0xff22aa, 0x75104e);
		public static const white:FlatShadeMaterial = new FlatShadeMaterial(light, 0xffffff, 0xffffff);
		public static const black:FlatShadeMaterial = new FlatShadeMaterial(light, 0x000000, 0x000000);
		public static const orange:FlatShadeMaterial = new FlatShadeMaterial(light, 0x00000, 0xff9931);
		public static const lightBlue:FlatShadeMaterial = new FlatShadeMaterial(light, 0X00000, 0x1d9999);
	
		private static function setLight(pPosX:Number,pPosY:Number,pPosZ:Number):PointLight3D
		{
			var light:PointLight3D = new PointLight3D();

			light.x = pPosX;
			light.y = pPosY;
			light.z = pPosZ;

			return light;
		}		
	}	
}
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

package flaras.io.fileSaver 
{
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import org.papervision3d.core.math.*;
	
	public class XMLGenerator
	{
		public static function generateXMLInteractionSphere(distanceToMarker:uint, size:uint):XML
		{
			var xml:XML = new XML("<data></data>");
			
			var infoNode:XML = new XML();
			infoNode = 
				<info>
					<distanceToMarker>{distanceToMarker}</distanceToMarker>
					<size>{size}</size>
				</info>
			xml.appendChild(infoNode);
			
			return xml;
		}
		
		public static function generateXMLPoints(pListOfPoints:Vector.<Point>):XML
		{
			var xml:XML = new XML("<pointsList><flarasProjectReleaseVersion>1069</flarasProjectReleaseVersion></pointsList>");
		
			for each(var p:Point in pListOfPoints)
			{
				var position:Number3D = p.getPosition();
				
				var newNode:XML = new XML();
				newNode = 
				<point>
					<position>
						<x>{position.x}</x>
						<y>{position.y}</y>
						<z>{position.z}</z>
					</position>
				<filePathObjectList>{p.getFilePathListOfObjects()}</filePathObjectList>					
				</point>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}
		
		public static function generateXMLObjects(pListOfObjects:Vector.<Object3D>):XML
		{
			var xml:XML = new XML("<objectsList></objectsList>");
			var concreteObject3D:ConcreteObject3D;
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var objChecked:Object3D;
			
			for each(var obj:Object3D in pListOfObjects)
			{
				var facadeObj3D:FacadeObject3D;
				
				facadeObj3D = new FacadeObject3D(obj);
				
				translation = facadeObj3D.getTranslation();
				rotation = facadeObj3D.getRotation();
				scale = facadeObj3D.getScale();
				
				var newNode:XML = new XML();
				newNode = 
				<object3D>
					<filePath>{facadeObj3D.getFilePath()}</filePath>
					<translation>
						<x>{translation.x}</x>
						<y>{translation.y}</y>
						<z>{translation.z}</z>
					</translation>
					<rotation>
						<x>{rotation.x}</x>
						<y>{rotation.y}</y>
						<z>{rotation.z}</z>
					</rotation>
					<scale>
						<x>{Math.abs(scale.x)}</x>
						<y>{scale.y}</y>
						<z>{scale.z}</z>
					</scale>
					{XMLGenerator.generateXMLTexture(facadeObj3D)}
					{XMLGenerator.generateXMLAudio(facadeObj3D)}
					{XMLGenerator.generateXMLVideo(facadeObj3D)}
					{XMLGenerator.generateXMLAnimation(facadeObj3D)}
				</object3D>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}
		
		private static function generateXMLTexture(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();
			
			xml = 
				<texture>
					<hasTexture>{uint(pFacadeObj3D.hasTexture())}</hasTexture>
					<texturePath>{pFacadeObj3D.getTexturePath()}</texturePath>
					<width>{pFacadeObj3D.getTextureWidth()}</width>
					<height>{pFacadeObj3D.getTextureHeight()}</height>
				</texture>;
		
			return xml;			
		}
		
		private static function generateXMLAudio(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();
		
			xml = 
				<audio>
					<hasAudio>{uint(pFacadeObj3D.hasAudio())}</hasAudio>
					<audioPath>{pFacadeObj3D.getAudioPath()}</audioPath>
					<repeatAudio>{uint(pFacadeObj3D.getRepeatAudio())}</repeatAudio>
				</audio>;
	
			return xml;
		}
		
		private static function generateXMLVideo(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();	
			
			xml = 
				<video>
					<hasVideo>{uint(pFacadeObj3D.hasVideo())}</hasVideo>
					<videoPath>{pFacadeObj3D.getVideoPath()}</videoPath>
					<width>{pFacadeObj3D.getVideoWidth()}</width>
					<height>{pFacadeObj3D.getVideoHeight()}</height>
					<repeatVideo>{uint(pFacadeObj3D.getRepeatVideo())}</repeatVideo>
				</video>;
					
			return xml;
		}
		
		private static function generateXMLAnimation(pFacadeObject3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();	
			
			xml = 
				<animation>
						<hasAnimation>{uint(pFacadeObject3D.hasAnimation())}</hasAnimation>
						<period>{pFacadeObject3D.getAnimationPeriod()}</period>
						<rotationAxis>{pFacadeObject3D.getAnimationRotationAxis()}</rotationAxis>
						<radius>{pFacadeObject3D.getAnimationRadius()}</radius>
						<rotationDirection>{pFacadeObject3D.getAnimationRotationDirection()}</rotationDirection>
					</animation>
					
			return xml;
		}
	}
}
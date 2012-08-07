package flaras.view.scene 
{
	import flaras.model.*;
	import flash.events.*;
	import flash.utils.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	
	public class ViewAnimationScene 
	{
		public static const X_ROTATION_AXIS:uint = 0;
		public static const Y_ROTATION_AXIS:uint = 1;
		public static const Z_ROTATION_AXIS:uint = 2;
		
		private var _viewFlarasScene:ViewFlarasScene;
		private var _animationScene:AnimationScene;
		private var _obj3DToAnimate:DisplayObject3D;
		
		private var _timer:Timer;
		private var _increaseAngleStep:Number;
		private var _angSumDegree:Number;
				
		public function ViewAnimationScene(animationScene:AnimationScene, viewFlarasScene:ViewFlarasScene) 
		{
			_animationScene = animationScene;
			_viewFlarasScene = viewFlarasScene;
			
			initAnimVars();
		}
		
		private function initAnimVars():void
		{
			_obj3DToAnimate = _viewFlarasScene.getObj3D();
		}
		
		public function showScene():void
		{
			if (_animationScene.getPeriod() != 0 && _timer == null)
			{
				initAnimVars();
				_timer = new Timer(33); //30 fps... 1 frap aprox every 33 ms
		
				//360º                - period (s)
				//increaseAngleStep   - 0.033 (s) (1 frame)
				_increaseAngleStep = _animationScene.getRotationDirection()*(360 * 0.03) / _animationScene.getPeriod();
				_angSumDegree = 0;
			
				_timer.addEventListener(TimerEvent.TIMER, animation);
				_timer.start();
			}
		}
		
		public function hideScene():void
		{
			unLoad();
		}		
		
		private function animation(e:Event):void
		{
			var angSumRad:Number;
			
			_angSumDegree += _increaseAngleStep;
			angSumRad = _angSumDegree * Math.PI / 180.0;
			
			if (_animationScene.getRotationAxis() == X_ROTATION_AXIS)
			{
				_obj3DToAnimate.y = getCurrentTranslation().y + _animationScene.getRadius() * Math.cos(angSumRad);
				_obj3DToAnimate.z = getCurrentTranslation().z + _animationScene.getRadius() * Math.sin(angSumRad);
				
				_obj3DToAnimate.rotationX = getCurrentRotation().x + _angSumDegree;				
			}
			else if (_animationScene.getRotationAxis() == Y_ROTATION_AXIS)
			{
				_obj3DToAnimate.x = getCurrentTranslation().x + _animationScene.getRadius() * Math.cos(angSumRad);
				_obj3DToAnimate.z = getCurrentTranslation().z + _animationScene.getRadius() * Math.sin(angSumRad);
				
				_obj3DToAnimate.rotationY = getCurrentRotation().y + _angSumDegree;
			}
			else
			{
				_obj3DToAnimate.x = getCurrentTranslation().x + _animationScene.getRadius() * Math.cos(angSumRad);
				_obj3DToAnimate.y = getCurrentTranslation().y + _animationScene.getRadius() * Math.sin(angSumRad);
				
				_obj3DToAnimate.rotationZ = getCurrentRotation().z + _angSumDegree;
			}
		}
		
		public function unLoad():void
		{
			if (_timer != null)
			{
				_timer.removeEventListener(TimerEvent.TIMER, animation);
				_timer.stop();
				_timer = null;
				
				_obj3DToAnimate.rotationX = getCurrentRotation().x;
				_obj3DToAnimate.rotationY = getCurrentRotation().y;
				_obj3DToAnimate.rotationZ = getCurrentRotation().z;
				
				_obj3DToAnimate.x = getCurrentTranslation().x;
				_obj3DToAnimate.y = getCurrentTranslation().y;
				_obj3DToAnimate.z = getCurrentTranslation().z;
			}
		}
		
		private function getCurrentTranslation():Number3D
		{
			return Number3D.add(_viewFlarasScene.getBaseFlarasScene().getTranslation(), _viewFlarasScene.getBaseFlarasScene().getParentPoint().getPosition());
		}
		
		private function getCurrentRotation():Number3D
		{
			return _viewFlarasScene.getBaseFlarasScene().getRotation();
		}
	}
}
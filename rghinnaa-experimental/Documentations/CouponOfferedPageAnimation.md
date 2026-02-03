# Coupon Offered Page Animation
The `Coupon Offered Page Animation` that transitions from a tab widget to sticky position and show/hide the view of tab filter when scrolling, and then show and hide the my coupon card entry is a UI pattern that enhances user experience when displaying coupon offers.

## Preview
![Coupon Offered Page Animation Preview](
https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1770103805/WhatsApp_GIF_2026-02-03_at_14.29.26_rgtjcs.gif)

## Installation
You can use or depends on swift and storyboard file in this repository placed at `rghinnaa-experimental/Views/Klik/Pages/CouponOfferedPage`

### Usage
- There's main components that used in this page
```Components needed
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var ivCouponOfferedBackground: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vToolbar: UIView!
    @IBOutlet weak var vMyCouponCard: CardMyCoupon!
    @IBOutlet weak var vBackgroundCoupon: UIView!
    @IBOutlet weak var btnBackToolbar: UIButton!
    @IBOutlet weak var lblToolbar: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
```
  
- Add this functions that working on it on UIScrollViewDelegate behavior
```Functions needed

// For Refresh Page
    private func updateRefresh() {
        if !refreshControl.isRefreshing && !isRefreshAnimating {
            let offsetY = scrollView.contentOffset.y
            let progress = min(abs(offsetY) / 60.0, 1.0)
            updateRefreshProgress(progress)
        }
    }
    
    private func updateRefreshProgress(_ progress: CGFloat) {
        guard !isRefreshAnimating else { return }
        
        let progress = min(max(progress, 0), 1)
        let rotation = CGAffineTransform(rotationAngle: .pi * 2 * progress)
        let scale = 0.2 + (0.8 * progress)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        refreshIconImageView.transform = rotation.concatenating(scaleTransform)
        refreshIconImageView.alpha = 0.5 + (0.5 * progress)
    }

// For Change Toolbar Color
    private func updateToolbarColor(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let progress = min(max((offsetY - toolbarHeight) / toolbarHeight, 0), 1)

        if offsetY > 0 {
            vToolbar.transform = CGAffineTransform(translationX: 0, y: offsetY)
        } else {
            vToolbar.transform = .identity
        }
        
        let newStyle: UIStatusBarStyle = progress > 0.9 ? .darkContent : .lightContent
        if currentStatusBarStyle != newStyle {
            currentStatusBarStyle = newStyle
            setNeedsStatusBarAppearanceUpdate()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.btnBackToolbar.tintColor = progress > 0.9 ? UIColor.grey50 : UIColor.white
            self.lblToolbar.textColor = progress > 0.9 ? UIColor.grey70 : UIColor.white
            self.containerView.backgroundColor = progress > 0.9 ? UIColor.white : .blue70
            self.ivCouponOfferedBackground.isHidden = progress > 0.9 ? true : false
        }
        
        self.vToolbar.backgroundColor = progress > 0.9 ? .white : .clear
    }

// For hide/show My Coupo Card Entry
    private func updateMyCouponCard(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let myCouponCardOffset = 1.1
        
        if offsetY > 0 && offsetY <= myCouponCardHeight {
            vMyCouponCard.transform = CGAffineTransform(translationX: 0, y: offsetY * myCouponCardOffset)
        } else if offsetY > myCouponCardHeight {
            vMyCouponCard.transform = CGAffineTransform(translationX: 0, y: myCouponCardHeight * myCouponCardOffset)
        } else {
            vMyCouponCard.transform = .identity
        }
    }

// For set the sticky header (tab level 1 and tab level 2)  
    private func updateStickyHeader(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? CouponOfferedHeaderView else { return }
        
        let fadeProgress = min(max(offsetY / myCouponCardHeight, 0), 1)
        vMyCouponCard.alpha = 1 - fadeProgress
        
        let stickyPoint = myCouponCardHeight
        let stickyOffset = offsetY - stickyPoint
        
        if offsetY >= stickyPoint {
            let hideTabFilterOffset: CGFloat = isTabFilterHidden ? -headerView.vTabFilter.frame.height : 0
            
            headerView.vTab.transform = CGAffineTransform(translationX: 0, y: stickyOffset)
            headerView.vTab.layer.cornerRadius = 0
            
            headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset + hideTabFilterOffset)
            headerView.vTabFilter.layer.shadowColor = UIColor.black?.cgColor
            headerView.vTabFilter.layer.shadowOpacity = 0.1
            headerView.vTabFilter.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.vTabFilter.layer.shadowRadius = 4
            headerView.vTabFilter.bgColor = .white
        } else {
            headerView.vTab.transform = .identity
            
            headerView.vTabFilter.bgColor = .clear
            headerView.vTabFilter.layer.shadowOpacity = 0
            
            UIView.animate(withDuration: 0.2) {
                headerView.vTabFilter.transform = .identity
            }
        }
    }

// For hide the tab filter when scrolling
    private func hideTabFilterView() {
        isTabFilterHidden = true
        
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? CouponOfferedHeaderView else { return }
        
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        let stickyOffset = max(0, offsetY - stickyPoint)
        
        UIView.animate(withDuration: 0.2) {
            headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset - headerView.vTabFilter.frame.height)
        }
    }

// For show the tab filter when scrolling
    private func showTabFilterView(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        
        if offsetY >= stickyPoint {
            isTabFilterHidden = false
            
            guard let headerView = collectionView.supplementaryView(
                forElementKind: UICollectionView.elementKindSectionHeader,
                at: IndexPath(item: 0, section: 0)
            ) as? CouponOfferedHeaderView else { return }
            
            let stickyOffset = max(0, offsetY - stickyPoint)
            
            UIView.animate(withDuration: 0.3) {
                headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset)
            }
        } else {
            isTabFilterHidden = false
        }
    }
```

- Add those function to the scroll delegate
```Scroll Behavior
    extension CouponOfferedViewController: UIScrollViewDelegate {
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
          updateRefresh()
          updateToolbarColor(scrollView)
          updateMyCouponCard(scrollView)
          updateStickyHeader(scrollView)
      }
      
      func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          let offsetY = scrollView.contentOffset.y
          let stickyPoint = myCouponCardHeight
          
          if offsetY >= stickyPoint {
              hideTabFilterView()
          }
      }
      
      func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
          if !decelerate {
              showTabFilterView(scrollView)
          }
      }
      
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          showTabFilterView(scrollView)
      }
    }
```
* * *

For further customization or to extend this animation, you can ask UX Engineer or Inherit the `Coupon Offered Page Animation` and override its methods or add additional functionality as required.

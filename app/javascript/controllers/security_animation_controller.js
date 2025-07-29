import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="security-animation"
export default class extends Controller {
  static targets = [ "shield", "innerShield", "checkmark", "featureCard" ]

  connect() {
    const observer = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.animate();
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.2 });

    observer.observe(this.element);
  }

  animate() {
    this.element.classList.add('is-visible');

    // Animate feature cards with a delay
    this.featureCardTargets.forEach((card, index) => {
      card.style.transitionDelay = `${index * 150}ms`;
      card.classList.add('fade-in-up');
    });
  }
}

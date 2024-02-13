{* Covid form html *}
<style>
	.b_bottom{
		text-decoration: underline;
	}
</style>

<h1>Waiver of Liability Relating to Coronavirus/COVID-19</h1>

<p>The novel coronavirus, COVID-19, has been declared a worldwide pandemic by the World Health Organization. COVID-19 is reported to be extremely contagious. The state of medical knowledge is evolving, but the virus is believed to spread from person-to-person contact and/or by contact with contaminated surfaces and objects, and even possibly in the air. People reportedly can be infected and show no symptoms and therefore spread the disease. The exact methods of spread and contraction are unknown, and there is no known treatment, cure, or vaccine for COVID-19. <span class="b_bottom">Evidence has shown that COVID-19 can cause serious and potentially life threatening illness and even death.</span></p>

<p><strong>Outpost Holdings, Inc., and its subsidiaries, Nebo Services Corp. and Outpost Club, Inc. (collectively, “Outpost”) cannot prevent you or your child(ren) from becoming exposed to, contracting, or spreading COVID-19 while utilizing Outpost’s services or premises.  While Outpost has put in place preventative measures to reduce the spread of the Coronavirus/COVID-19, it is not possible to prevent against the presence of the disease. Therefore, if you choose to utilize Outpost’s services and/or enter onto Outpost’s premises you may be exposing yourself to and/or increasing your risk of contracting or spreading COVID-19.</strong></p>

<p><strong><span class="b_bottom">ASSUMPTION OF RISK</span>:  I have read and understood the above warning concerning COVID-19.</strong> I hereby choose to accept the risk of contracting COVID-19 for myself and/or my children in order to utilize Outpost’s services and enter Outpost’s premises. These services are of such value to me and/or to my children, that I accept the risk of being exposed to, contracting, and/or spreading COVID-19 in order to utilize Outpost’s services and premises in person.  I understand that the risk of becoming exposed to and/or infected by the Coronavirus/COVID-19 may result from the actions, omissions, or negligence of myself and others, including, but not limited to, and other clients and their families</p>

<p><strong class="b_bottom">ACCEPTANCE OF COVID-19 POLICIES AND PROCEDURES</strong>:  I voluntarily seek services provided by Outpost and acknowledge that I am increasing my risk to exposure to the Coronavirus/COVID-19. I acknowledge that I must comply with all set procedures to reduce the spread while utilizing such services. Outpost’s Policies and Procedures, as well as any updates thereto, can be found here: <a href="https://outpost-club.com/covid-19" target="_blank">https://outpost-club.com/covid-19</a></p>

<p><strong class="b_bottom">ATTESTATION</strong>:  I hereby attest the following:</p>

<ul>
	<li>I am not experiencing any symptoms of illness such as cough, shortness of breath or difficulty breathing, fever, chills, repeated shaking with chills, muscle pain, headache, sore throat, or new loss of taste or smell</li>
	<li>I have not traveled internationally within the last 14 days. If I did - I got a COVID test prior to the travel to the USA and had been tested negative for COVID.</li>
	<li>I have not traveled to a highly impacted area within the United States of America in the last 14 days. If I did - I got a COVID test prior to the travel to NY or NJ and had been tested negative for COVID. </li>
	<li>I do not believe I have been exposed to someone with a suspected and/or confirmed case of the Coronavirus/COVID-19</li>
	<li>I have not been diagnosed with Coronavirus/Covid-19 and not yet been determined as being non-contagious by state or local public health authorities</li>
	<li>I am following all CDC and State and Local recommended guidelines as much as possible and limiting my exposure to the Coronavirus/COVID-19</li>
</ul>

<p><strong><span class="b_bottom">WAIVER OF LAWSUIT/LIABILITY</span>: I hereby forever release and waive my right to bring suit against Outpost and its owners, officers, directors, managers, officials, trustees, agents, employees, or other representatives in connection with exposure, infection, and/or spread of COVID-19 related to utilizing Outpost’s services and premises.</strong> I understand that this waiver means I give up my right to bring any claims including for personal injuries, death, disease or property losses, or any other loss, including but not limited to claims of negligence and give up any claim I may have to seek damages, whether known or unknown, foreseen or unforeseen.</p>

<p>CHOICE OF LAW: I understand and agree that the law of the State of New York will apply to this contract.</p>

<p><strong>I HAVE CAREFULLY READ AND FULLY UNDERSTAND ALL PROVISIONS OF THIS RELEASE, AND FREELY AND KNOWINGLY ASSUME THE RISK AND WAIVE MY RIGHTS CONCERNING LIABILITY AS DESCRIBED ABOVE</strong> or I am the parent or legal guardian of the minor named above. I have the legal right to consent to and, by signing below, I hereby do consent to the terms and conditions of this Release.</p>

<p>
	NAME: {$user->name|escape}<br/>
	DATE: {$date_signing|date:'m/d/Y'}<br/>
{if $signature}
	SIGNATURE:<br>
	<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
{/if}
</p>
